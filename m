Received: from eggs.gnu.org ([2001:4830:134:3::10]:47725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cd4Yw-0000W4-Fs
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 19:32:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cd4Yv-00041w-3F
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 19:32:14 -0500
Received: from mail-pg0-x235.google.com ([2607:f8b0:400e:c05::235]:33541)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1cd4Yu-00041Z-QS
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 19:32:13 -0500
Received: by mail-pg0-x235.google.com with SMTP id 204so27234379pge.0
	for <qemu-devel@nongnu.org>; Sun, 12 Feb 2017 16:32:11 -0800 (PST)
From: Ben Warren <ben@skyportsystems.com>
Message-Id: <C0100FF9-1A31-4A95-AC26-D213E5341807@skyportsystems.com>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_A86288DC-6EDA-448E-82C9-9D9C429A2226";
	protocol="application/pkcs7-signature"; micalg=sha1
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date: Sun, 12 Feb 2017 16:32:08 -0800
In-Reply-To: <9124f4d8-f4a2-b7b4-9187-e52785cf55ef@gmail.com>
References: <cover.1486285434.git.ben@skyportsystems.com>
	<a0d502ddafd0bb57633d863c8b2d89693ad5b06f.1486285434.git.ben@skyportsystems.com>
	<20170206182941-mutt-send-email-mst@kernel.org>
	<9124f4d8-f4a2-b7b4-9187-e52785cf55ef@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v5 08/10] PC: Support dynamic sysbus on
 pc_i440fx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcel@redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, imammedo@redhat.com, lersek@redhat.com, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.a@redhat.com>


--Apple-Mail=_A86288DC-6EDA-448E-82C9-9D9C429A2226
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi
> On Feb 12, 2017, at 11:55 AM, Marcel Apfelbaum =
<marcel.apfelbaum@gmail.com> wrote:
>=20
> On 02/06/2017 06:31 PM, Michael S. Tsirkin wrote:
>> On Sun, Feb 05, 2017 at 01:12:03AM -0800, ben@skyportsystems.com =
wrote:
>>> From: Ben Warren <ben@skyportsystems.com>
>>>=20
>>> This allows pc_i440fx-based machines to add new devices such as
>>> VM Generation ID directly to the sysbus.
>>>=20
>>> Signed-off-by: Ben Warren <ben@skyportsystems.com>
>>=20
>=20
> Hi,
>=20
>> Only point is, we might have to add more flags like
>> cannot_instantiate_with_device_add_yet
>> to a bunch of devices.
>>=20
>> Marcel, you did a similar thing for q35, can you
>> take a look here as well pls?
>>=20
>=20
> The change is a must because the new vmgenid device
> is a sysbus device and QEMU will not allow it without
> marking explicitly that i440fx supports sysbus device.
>=20
As recommended by Igor, I was able to make the vmgenid work with =
DeviceClass as parent (i.e. not on sysbus), so this work can be deferred =
until it=E2=80=99s really needed.  The next patch set (hopefully posted =
tonight) will drop this patch.
> As you already mentioned, we need to make sure that
> all sysbus devices that can be added to the PC machines
> are marked with "cannot_instantiate_with_device_add_yet".
>=20
> Sadly I see no easy way, but going manually over each one...
>=20
> Thanks,
> Marcel
>=20
=E2=80=94Ben
>>> ---
>>> hw/i386/pc_piix.c | 1 +
>>> 1 file changed, 1 insertion(+)
>>>=20
>>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>>> index 9f102aa..c8ad99c 100644
>>> --- a/hw/i386/pc_piix.c
>>> +++ b/hw/i386/pc_piix.c
>>> @@ -435,6 +435,7 @@ static void =
pc_i440fx_machine_options(MachineClass *m)
>>>     m->hot_add_cpu =3D pc_hot_add_cpu;
>>>     m->default_machine_opts =3D "firmware=3Dbios-256k.bin";
>>>     m->default_display =3D "std";
>>> +    m->has_dynamic_sysbus =3D true;
>>> }
>>>=20
>>> static void pc_i440fx_2_9_machine_options(MachineClass *m)
>>> --
>>> 2.7.4
>>=20
>=20


--Apple-Mail=_A86288DC-6EDA-448E-82C9-9D9C429A2226
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
CQUxDxcNMTcwMjEzMDAzMjA4WjAjBgkqhkiG9w0BCQQxFgQUSBKQAra6+KblfRtqlz++5GCv6b4w
gcIGCSsGAQQBgjcQBDGBtDCBsTCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFu
Y2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxQTA/
BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVt
YWlsIENBAhEAljnjFZYn8wPj7xnx4zHsmzCBxAYLKoZIhvcNAQkQAgsxgbSggbEwgZsxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQg
QXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJY54xWWJ/MD4+8Z8eMx7JswDQYJ
KoZIhvcNAQEBBQAEggEAka0dlaikETVC/5EW4J8AGDM3U5MIHq3LO4ReYHKJuU3BDatbPMkBH2Ke
0Q4CfFu8jBFFeQeVsHCcrpu8JH5xW7cRo3B8MqV6WR9VlI5A66wo9737uOJxsLgfeRGiR1HayxUW
a9FQ18/FIENFd0nb7ljjm+RdbEEGwGVYez+SlCau6U3hhZRyLAnFiDCepSlz2+odjPnwHysGdOH2
ODIDk1Mf7PRukPW7PgyRMjb8g/3Ade1N124zB4asxTLdJLn1abQjvQkrbOH8is4Gb0kM5lD0xKKP
hD5OfQI1VnioZtnM5p1SGZs6ozEr3yPRwmi4467ic/DpLxu2wZWDF92I9wAAAAAAAA==
--Apple-Mail=_A86288DC-6EDA-448E-82C9-9D9C429A2226--
