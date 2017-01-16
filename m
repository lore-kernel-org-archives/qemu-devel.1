Received: from eggs.gnu.org ([2001:4830:134:3::10]:38130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cTDaJ-0003NC-AM
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 15:08:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cTDaG-0004AX-KK
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 15:08:55 -0500
Received: from mail-pg0-x22b.google.com ([2607:f8b0:400e:c05::22b]:34414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1cTDaG-0004AA-86
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 15:08:52 -0500
Received: by mail-pg0-x22b.google.com with SMTP id 14so17913839pgg.1
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 12:08:52 -0800 (PST)
From: Ben Warren <ben@skyportsystems.com>
Message-Id: <EE421B2A-48D8-40AE-B6A2-0261F4B1524E@skyportsystems.com>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_C477E2FC-B043-45D0-8904-465406DC0CCF";
	protocol="application/pkcs7-signature"; micalg=sha1
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date: Mon, 16 Jan 2017 12:08:49 -0800
In-Reply-To: <a4fa1114-56b0-e996-2756-d9f2e96ca7c7@redhat.com>
References: <cover.1484593565.git.ben@skyportsystems.com>
	<d8737523bcb760c29d8d5ca9bd86800fca9cb3c1.1484594095.git.ben@skyportsystems.com>
	<a4fa1114-56b0-e996-2756-d9f2e96ca7c7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/6] docs: vm generation id device's
 description
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Gal Hammer <ghammer@redhat.com>


--Apple-Mail=_C477E2FC-B043-45D0-8904-465406DC0CCF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On Jan 16, 2017, at 11:51 AM, Eric Blake <eblake@redhat.com> wrote:
>=20
> On 01/16/2017 01:20 PM, ben@skyportsystems.com =
<mailto:ben@skyportsystems.com> wrote:
>> From: Ben Warren <ben@skyportsystems.com =
<mailto:ben@skyportsystems.com>>
>=20
> meta-comment: This message was sent with headers:
>> Message-Id: =
<d8737523bcb760c29d8d5ca9bd86800fca9cb3c1.1484594095.git.ben@skyportsystem=
s.com =
<mailto:d8737523bcb760c29d8d5ca9bd86800fca9cb3c1.1484594095.git.ben@skypor=
tsystems.com>>
>> In-Reply-To: <cover.1484593565.git.ben@skyportsystems.com =
<mailto:cover.1484593565.git.ben@skyportsystems.com>>
>> References: <cover.1484593565.git.ben@skyportsystems.com =
<mailto:cover.1484593565.git.ben@skyportsystems.com>>
>> In-Reply-To: <cover.1484594095.git.ben@skyportsystems.com =
<mailto:cover.1484594095.git.ben@skyportsystems.com>>
>> References: <cover.1484594095.git.ben@skyportsystems.com =
<mailto:cover.1484594095.git.ben@skyportsystems.com>>
>=20
> while your cover letter's actual headers included:
>> Message-Id: <cover.1484593565.git.ben@skyportsystems.com =
<mailto:cover.1484593565.git.ben@skyportsystems.com>>
>=20
> I don't know how you got your sending side to use two different sets =
of
> In-Reply-To, but it breaks at least Thunderbird's abilities to =
rethread
> the messages (thunderbird apparently only pays attention to the last
> header, while only the first one would cause correct threading).
>=20
Hmm, I created the patches using =E2=80=9Cgit format-patch=E2=80=9D with =
the =E2=80=94thread switch, then =E2=80=98git send-email=E2=80=99, which =
is usually a solid combination.  I=E2=80=99ll dry-run it next time to =
make sure things are threaded properly.  Sorry.
>=20
>>=20
>> Signed-off-by: Ben Warren <ben@skyportsystems.com =
<mailto:ben@skyportsystems.com>>
>> Cc: Gal Hammer <ghammer@redhat.com <mailto:ghammer@redhat.com>>
>=20
> If you are basing this patch off of earlier work (for example, you
> mentioned Igor's work), you may need additional S-o-b lines for work =
you
> copied from the earlier versions.
>=20
yes, I used a previous patch set as a baseline and want to make sure =
credit goes to whoever did the real work.  In this case, Gal Hammer was =
the original author, so I CC=E2=80=99d Him (or her) hoping to get an =
SOB.  Should that be handled out-of-band?
>> ---
>> docs/specs/vmgenid.txt | 38 ++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 38 insertions(+)
>> create mode 100644 docs/specs/vmgenid.txt
>>=20
>> diff --git a/docs/specs/vmgenid.txt b/docs/specs/vmgenid.txt
>> new file mode 100644
>> index 0000000..afc1717
>> --- /dev/null
>> +++ b/docs/specs/vmgenid.txt
>> @@ -0,0 +1,38 @@
>> +VIRTUAL MACHINE GENERATION ID
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>> +
>> +Copyright (C) 2016 Red Hat, Inc.
>=20
> Claiming Red Hat copyright makes it sound like you are basing this off
> an earlier version.  That is the correct thing to do if you indeed
> copied something with Red Hat copyright, but seems weird if you wrote =
it
> from scratch.
Same as above, I reworked much of this document, but a great deal is not =
my original.  Guidance on the right way to do this is appreciated.
>=20
>> +Copyright (C) 2016 Skyport Systems, Inc.
>=20
> Do you want to claim 2017 as well?
>=20
Good catch, I haven=E2=80=99t touched the file this year, but that makes =
sense.
>=20
>> +
>> +The vmgenid device is a sysbus device with the ACPI ID =
"QEMU_Gen_Counter_V1".
>> +
>> +The device has one properties, which can be set using the command =
line
>=20
> s/properties/property/
Will fix.
>=20
>> +argument or the QMP interface:
>> + guid - sets the value of the GUID
>> +For example:
>> +QEMU  -device vmgenid,guid=3D"324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"
>> +
>=20
> --=20
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org =
<http://libvirt.org/>

--Apple-Mail=_C477E2FC-B043-45D0-8904-465406DC0CCF
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
CQUxDxcNMTcwMTE2MjAwODUwWjAjBgkqhkiG9w0BCQQxFgQUcQ0Zox3OvUj//ZLVpPHC+/hE6HUw
gcIGCSsGAQQBgjcQBDGBtDCBsTCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFu
Y2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxQTA/
BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVt
YWlsIENBAhEAljnjFZYn8wPj7xnx4zHsmzCBxAYLKoZIhvcNAQkQAgsxgbSggbEwgZsxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQg
QXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJY54xWWJ/MD4+8Z8eMx7JswDQYJ
KoZIhvcNAQEBBQAEggEArlpQxm5246DHhg4TdJ9+fwoAEafjUWjM52vxn8WHOPkC/Zvbih1wfYat
NcAHYMPIuypU/r7GAvwDy+nScG/hHO0RkQAy7le31++8jI1HGgQc7dMdYf9pqC2U6OEAbYsTlaY2
VoT22mwIRHgBdQpXW8nw07YIjET/YK8PnjIvoq5CWHNUu1miDq4QxPaO5SuxRk31NVO/0vL5bHG6
YOyufo57dqHju1BLvb1cS1aIc3/uQwZsmnm8L45Uztd7KxcqZqmAF2UI4ckBVLb2YUfrneUZccy3
ut8Te7LO4XMDclDayyGvMD8/jPblXupKHUfcOVrxjEqTLhZVouPWEn0nYgAAAAAAAA==
--Apple-Mail=_C477E2FC-B043-45D0-8904-465406DC0CCF--
