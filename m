Received: from eggs.gnu.org ([2001:4830:134:3::10]:41164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cXB7v-0007yv-W8
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 13:20:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cXB7p-0002Ce-RE
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 13:19:59 -0500
Received: from mail-pg0-x231.google.com ([2607:f8b0:400e:c05::231]:36193)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1cXB7p-0002BR-FT
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 13:19:53 -0500
Received: by mail-pg0-x231.google.com with SMTP id 3so24413791pgj.3
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 10:19:51 -0800 (PST)
From: Ben Warren <ben@skyportsystems.com>
Message-Id: <B4113FC0-72BC-494A-90DB-8AA3C67D74F4@skyportsystems.com>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_CD15C37C-EC86-48F5-8E9F-526A5FB41B44";
	protocol="application/pkcs7-signature"; micalg=sha1
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date: Fri, 27 Jan 2017 10:19:49 -0800
In-Reply-To: <0e627b59-08ad-ac77-5a7b-c80c0b027406@redhat.com>
References: <29F9E21E-D768-47D8-8E7F-BBC9DC4F72DD@skyportsystems.com>
	<20170125202812-mutt-send-email-mst@kernel.org>
	<2497755c-8616-1f42-ff36-ad75f6778a52@redhat.com>
	<20170126165015-mutt-send-email-mst@kernel.org>
	<adbfd67b-bcbc-2da2-78be-810eb35781ec@redhat.com>
	<20170126201124-mutt-send-email-mst@kernel.org>
	<6d15ef62-3184-3293-dd83-da67dd48dab0@redhat.com>
	<20170126205508-mutt-send-email-mst@kernel.org>
	<20170127141854.GA2524@morn.lan>
	<58bbf216-a2f1-481f-21b0-4ada4f73a5e5@redhat.com>
	<20170127154313.GB7213@morn.lan>
	<0e627b59-08ad-ac77-5a7b-c80c0b027406@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/9] ACPI: Add a function for building
 named qword entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Kevin O'Connor <kevin@koconnor.net>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org


--Apple-Mail=_CD15C37C-EC86-48F5-8E9F-526A5FB41B44
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On Jan 27, 2017, at 8:12 AM, Laszlo Ersek <lersek@redhat.com> wrote:
>=20
> On 01/27/17 16:43, Kevin O'Connor wrote:
>> On Fri, Jan 27, 2017 at 03:46:33PM +0100, Laszlo Ersek wrote:
>>> On 01/27/17 15:18, Kevin O'Connor wrote:
>>>> If an offset is going to be added, shouldn't both a source offset =
and
>>>> destination offset be used?
>>>>=20
>>>>        /*
>>>>         * COMMAND_WRITE_POINTER - update a writeable file named
>>>>         * @pointer.dest_file at @pointer.dest_offset, by writing =
pointer
>>>>         * plus @pointer.src_offset to the blob originating from
>>>>         * @src_file. 1,2,4 or 8 byte unsigned write is used =
depending
>>>>         * on @pointer.size.
>>>>         */
>>>>        struct {
>>>>            char dest_file[BIOS_LINKER_LOADER_FILESZ];
>>>>            char src_file[BIOS_LINKER_LOADER_FILESZ];
>>>>            uint32_t src_offset, dest_offset;
>>>>            uint8_t size;
>>>>        } pointer;
>>>>=20
>>>> I doubt the offsets or size is really all that important though.
>>>=20
>>> The offset into the fw_cfg file that receives the allocation address =
is
>>> important, that allows the same file to receive several different
>>> addresses (for different downloaded blobs), at different offsets.
>>>=20
>>> OTOH, asking the firmware to add a constant to the address value =
before
>>> writing it to the fw_cfg file is not necessary, in my opinion. The =
blob
>>> that the firmware allocated and downloaded originates from QEMU to =
begin
>>> with, so QEMU knows its internal structure.
>>=20
>> I guess I'm missing why QEMU would want to use the same writable file
>> for multiple pointers
>=20
> I know no specific reason; I just thought this possible generalization
> was one of the advantages in Michael's suggestion.
>=20
>> as well as why it would want support for
>> pointers smaller than 8 bytes in size.
>=20
> Hm, right, good point.
>=20
>> If it's because it may be
>> easier to support an internal QEMU blob of a particular format, then
>> adding a src_offset would facilitate that.
>>=20
>> However, if it was done so that WRITE_POINTER mimicks ADD_POINTER =
then
>> that's fine too.
>=20
> That might be the main reason I guess; reading back a bit, Michael =
wrote
> "... a variant of ADD_POINTER".
>=20
>> I'm okay with either format.
>=20
> I'd say let's go ahead with Michael's proposal then. Ben, are you okay
> with that?
>=20
Yes, this seems reasonable.  If I=E2=80=99m interpreting this properly, =
it=E2=80=99s like ADD_POINTER, except that we extend the write path back =
to QEMU over DMA.  Is that about right?

> Thanks!
> Laszlo
=E2=80=94Ben


--Apple-Mail=_CD15C37C-EC86-48F5-8E9F-526A5FB41B44
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJ+zCCBK8w
ggOXoAMCAQICEQDgI8sVEoNTia1hbnpUZ2shMA0GCSqGSIb3DQEBCwUAMG8xCzAJBgNVBAYTAlNF
MRQwEgYDVQQKEwtBZGRUcnVzdCBBQjEmMCQGA1UECxMdQWRkVHJ1c3QgRXh0ZXJuYWwgVFRQIE5l
dHdvcmsxIjAgBgNVBAMTGUFkZFRydXN0IEV4dGVybmFsIENBIFJvb3QwHhcNMTQxMjIyMDAwMDAw
WhcNMjAwNTMwMTA0ODM4WjCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hl
c3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxQTA/BgNV
BAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWls
IENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAibEN2npTGU5wUh28VqYGJre4SeCW
51Gr8fBaE0kVo7SMG2C8elFCp3mMpCLfF2FOkdV2IwoU00oCf7YdCYBupQQ92bq7Fv6hh6kuQ1JD
FnyvMlDIpk9a6QjYz5MlnHuI6DBk5qT4VoD9KiQUMxeZrETlaYujRgZLwjPU6UCfBrCxrJNAubUI
kzqcKlOjENs9IGE8VQOO2U52JQIhKfqjfHF2T+7hX4Hp+1SA28N7NVK3hN4iPSwwLTF/Wb1SN7Az
aS1D6/rWpfGXd2dRjNnuJ+u8pQc4doykqTj/34z1A6xJvsr3c5k6DzKrnJU6Ez0ORjpXdGFQvsZA
P8vk4p+iIQIDAQABo4IBFzCCARMwHwYDVR0jBBgwFoAUrb2YejS0Jvf6xCZU7wO94CTLVBowHQYD
VR0OBBYEFJJha4LhoqCqT+xn8cKj97SAAMHsMA4GA1UdDwEB/wQEAwIBhjASBgNVHRMBAf8ECDAG
AQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDARBgNVHSAECjAIMAYGBFUdIAAw
RAYDVR0fBD0wOzA5oDegNYYzaHR0cDovL2NybC51c2VydHJ1c3QuY29tL0FkZFRydXN0RXh0ZXJu
YWxDQVJvb3QuY3JsMDUGCCsGAQUFBwEBBCkwJzAlBggrBgEFBQcwAYYZaHR0cDovL29jc3AudXNl
cnRydXN0LmNvbTANBgkqhkiG9w0BAQsFAAOCAQEAGypurFXBOquIxdjtzVXzqmthK8AJECOZD8Vm
am+x9bS1d14PAmEA330F/hKzpICAAPz7HVtqcgIKQbwFusFY1SbC6tVNhPv+gpjPWBvjImOcUvi7
BTarfVil3qs7Y+Xa1XPv7OD7e+Kj//BCI5zKto1NPuRLGAOyqC3U2LtCS5BphRDbpjc06HvgARCl
nMo6x59PiDRuimXQGoq7qdzKyjbR9PzCZCk1r9axp3ER0gNDsY8+muyeMlP0dpLKhjQHuSzK5hxK
2JkNwYbikJL7WkJqIyEQ6WXH9dW7fuqMhSACYurROgcsWcWZM/I4ieW26RZ6H3kU9koQGib6fIr7
mzCCBUQwggQsoAMCAQICEQCWOeMVlifzA+PvGfHjMeybMA0GCSqGSIb3DQEBCwUAMIGbMQswCQYD
VQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRow
GAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDFBMD8GA1UEAxM4Q09NT0RPIFNIQS0yNTYgQ2xpZW50
IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwHhcNMTYwNTE5MDAwMDAwWhcNMTcw
NTE5MjM1OTU5WjAnMSUwIwYJKoZIhvcNAQkBFhZiZW5Ac2t5cG9ydHN5c3RlbXMuY29tMIIBIjAN
BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAryjnKj/3VRzbNXiWAp7RAZSzUCOzDG6WJ2ybuDWP
A7uDl48iX2v3ulbcZq8G0sL1nwGvBdSrmd5X3Qzirx0ti0Qe0mlAd22PEOL/xR5ChLDhNI6i43cM
R1qM1JNtuC5Dz8h2TfYbF/VuKkA1YVuXNguSP8Z1DQXptE1m3yS0gk9LLdDkqq7Vi/zfSmD1NYHN
gEGvtux/3lMp8pHgQiZo8PxKH2Y4zem0AiWtZ9fKZqYWRIhECJ+etvpGvh4dNIj8vdo/ig3uSwLv
ePX7rFz3C5WHOyKjl4VGHNOA5IRZjabp4bdAEIiMPU7lfWt0o4nCRtM/G/6FvFinR6PIHSma1wID
AQABo4IB9DCCAfAwHwYDVR0jBBgwFoAUkmFrguGioKpP7GfxwqP3tIAAwewwHQYDVR0OBBYEFJv6
uT+NCtbUQ0MHZLryEY65oKgbMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMCAGA1UdJQQZ
MBcGCCsGAQUFBwMEBgsrBgEEAbIxAQMFAjARBglghkgBhvhCAQEEBAMCBSAwRgYDVR0gBD8wPTA7
BgwrBgEEAbIxAQIBAQEwKzApBggrBgEFBQcCARYdaHR0cHM6Ly9zZWN1cmUuY29tb2RvLm5ldC9D
UFMwXQYDVR0fBFYwVDBSoFCgToZMaHR0cDovL2NybC5jb21vZG9jYS5jb20vQ09NT0RPU0hBMjU2
Q2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNybDCBkAYIKwYBBQUHAQEEgYMw
gYAwWAYIKwYBBQUHMAKGTGh0dHA6Ly9jcnQuY29tb2RvY2EuY29tL0NPTU9ET1NIQTI1NkNsaWVu
dEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcnQwJAYIKwYBBQUHMAGGGGh0dHA6Ly9v
Y3NwLmNvbW9kb2NhLmNvbTAhBgNVHREEGjAYgRZiZW5Ac2t5cG9ydHN5c3RlbXMuY29tMA0GCSqG
SIb3DQEBCwUAA4IBAQAwVeCMNqTr20+cqsHnSK2AtzxKZyVG9y51wB88lPnRGHe2m+qKGdPgAh/7
iDzEEXsy4sDwHVHVq4kLHW9lX7CvRTxCtmOAtsty5ePhJjh3CX+nsK2HKpi043E6azad6L64DNVN
dMZFwUrUu8dYjOp48TPpIhW13Sbu2t/SOZK4G8EZAaZPX8Dg34tyHRUvM/B/eaJuUgdM5qY2IU+F
7U2K4hBHkhJMJgQ7TyVe8GhdBMaztY4GHqhWP5cCgZBdC9QII8E5jqX7//FbBRB0zVHRVeBZO32H
TvapSOG8ZYd0n5l5j3rBQnLfHWsnQ07rL2+w8W9BBPSZBbciPuwOe3ksMYIDxjCCA8ICAQEwgbEw
gZsxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1Nh
bGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1
NiBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJY54xWWJ/MD4+8Z
8eMx7JswCQYFKw4DAhoFAKCCAekwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMTcwMTI3MTgxOTUwWjAjBgkqhkiG9w0BCQQxFgQUcxRFi9k2+IiNYBVxg/sY+H+3FJ4w
gcIGCSsGAQQBgjcQBDGBtDCBsTCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFu
Y2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxQTA/
BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVt
YWlsIENBAhEAljnjFZYn8wPj7xnx4zHsmzCBxAYLKoZIhvcNAQkQAgsxgbSggbEwgZsxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQg
QXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJY54xWWJ/MD4+8Z8eMx7JswDQYJ
KoZIhvcNAQEBBQAEggEAlPRDYUOhePND2nhxb6p3DF+yZbPZmBzyoZ8MUK4wMybis/lx/k1COeD+
fhRDynTaoycIhRlixRE/5o+oabXO7DdgUklubNcEQ+nJAfH4KGYxUw55jraguIDmAvORBBit5v7z
Cqp2N+Bv7jWJ7CCXlZS6YLHszlccxDGa5yKnze4UC0QyGBWEVSPG3b8UeyufmkChs1GUfmHvZAGq
dmGTNWiBugX51lFnAoGHqeOFZXtTO6zLbai2gq0dfWnzGDIXaEaltO8rmDIRrRECvgJnYuRnB5nt
e5m2Av6ulRVqeCO5CC2nTQLgqmyb+qA/6rZiJAImgqJjPgjiW+tl9dzh5wAAAAAAAA==
--Apple-Mail=_CD15C37C-EC86-48F5-8E9F-526A5FB41B44--
