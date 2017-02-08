Received: from eggs.gnu.org ([2001:4830:134:3::10]:58227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cbYmn-0004lR-UG
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 15:24:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cbYmj-0006M4-Qd
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 15:24:17 -0500
Received: from mail-io0-x22a.google.com ([2607:f8b0:4001:c06::22a]:36284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1cbYmj-0006Ly-Hw
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 15:24:13 -0500
Received: by mail-io0-x22a.google.com with SMTP id j13so125759374iod.3
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 12:24:13 -0800 (PST)
From: Ben Warren <ben@skyportsystems.com>
Message-Id: <E5164ADC-BF50-4052-BA38-DE05D7CFEAC8@skyportsystems.com>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_4219616D-3493-43EC-A854-0093E45D96E4";
	protocol="application/pkcs7-signature"; micalg=sha1
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date: Wed, 8 Feb 2017 12:24:10 -0800
In-Reply-To: <9a6c7225-0b57-fdc6-4a43-49068b175842@redhat.com>
References: <cover.1486285434.git.ben@skyportsystems.com>
	<e531606c10f3c40dbc10d0fa4a4a5d806d7946d9.1486285434.git.ben@skyportsystems.com>
	<20170207145151.42fb0cc6@nial.brq.redhat.com>
	<b0dac808-e617-616e-6a1b-11c242b9250a@redhat.com>
	<20170208114347.2bc8ae2b@nial.brq.redhat.com>
	<9a6c7225-0b57-fdc6-4a43-49068b175842@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 01/10] ACPI: Add a function for building
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
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com


--Apple-Mail=_4219616D-3493-43EC-A854-0093E45D96E4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On Feb 8, 2017, at 2:53 AM, Laszlo Ersek <lersek@redhat.com> wrote:
>=20
> On 02/08/17 11:43, Igor Mammedov wrote:
>> On Tue, 7 Feb 2017 21:09:27 +0100
>> Laszlo Ersek <lersek@redhat.com> wrote:
>>=20
>>> On 02/07/17 14:51, Igor Mammedov wrote:
>>>> On Sun,  5 Feb 2017 01:11:56 -0800
>>>> ben@skyportsystems.com wrote:
>>>>=20
>>>>> From: Ben Warren <ben@skyportsystems.com>
>>>>>=20
>>>>> This is initially used to patch a 64-bit address into
>>>>> the VM Generation ID SSDT
>>>>>=20
>>>>> Signed-off-by: Ben Warren <ben@skyportsystems.com>
>>>>> --- =20
>>>> ... =20
>>>>> +int
>>>>> +build_append_named_qword(GArray *array, const char *name_format, =
...) =20
>>>> it ain't used anywhere, I'd just drop this patch. =20
>>>=20
>>> Ben and I discussed this under
>>> - msgid <6E25852D-224A-4BDC-AA83-8DC87DB4D0F0@skyportsystems.com>
>>>  https://www.mail-archive.com/qemu-devel@nongnu.org/msg425496.html
>>> - msgid <a93a6be3-cbed-5afe-7c72-96410fbfce41@redhat.com>
>>>  https://www.mail-archive.com/qemu-devel@nongnu.org/msg425519.html
>>>=20
>>> On 01/26/17 06:35, Ben Warren wrote:
>>>> I propose to still include this patch but touch up the comments as
>>>> requested by Laszlo.  This way it will be in the toolbox for future
>>>> users and has been tested.  [...] =20
>>>=20
>>> I generally agree that dead code is undesirable, but this function =
has
>>> surfaced several times until now, and we get to review it every =
single
>>> time. Ben tested it, I support its inclusion.
>>>=20
>>> OTOH I also pointed it out to Ben
>>>=20
>>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg425218.html
>>>=20
>>> that he should expect disagreement between his reviewers :) Given =
that
>>> I'm observing this series more from the sidelines and you maintain /
>>> support ACPI gen in QEMU, I certainly defer to you on this.
>> It's not only dead, having patchable QWORD ready for use in QEMU
>> would tempt someone to use it and that would lead to XP BSOD
>> if it slips screening at review time.
>=20
> Good point.
>=20
>> I'd delay this patch until
>> we announce that ACPI 1.0 (XP based) guest no more supported by
>> new QEMU.
>>=20
>> Anyway I won't object to merging this if you insist and give it your =
RB.
>=20
> No, you are entirely right. As long as we consider Windows XP guests
> first class citizens (i.e., we even reject the idea of additional
> command line options), then keeping QWORD "out of sight" is safer.
>=20
> Follow up question: when are we going to drop Windows XP? Do we have a
> plan? :) It's quite a struggle to support both ends of the spectrum =
with
> the same machine types and options (decades-old DOS and Windows XP vs.
> supercomputer-class NUMA setups). I think this limits development.
>=20
> (Just curious; I'm not suggesting to drop Windows XP "soon".)
>=20
> Thanks!
> Laszlo
>=20
OK, I=E2=80=99ll drop this patch from the set.  I guess it will always =
be around if we want to resurrect.
>=20
>>>=20
>>>=20
>>>>> +{
>>>>> +    int offset;
>>>>> +    va_list ap;
>>>>> +
>>>>> +    build_append_byte(array, 0x08); /* NameOp */
>>>>> +    va_start(ap, name_format);
>>>>> +    build_append_namestringv(array, name_format, ap);
>>>>> +    va_end(ap);
>>>>> +
>>>>> +    build_append_byte(array, 0x0E); /* QWordPrefix */
>>>>> +
>>>>> +    offset =3D array->len;
>>>>> +    build_append_int_noprefix(array, 0x0000000000000000, 8);
>>>>> +    assert(array->len =3D=3D offset + 8);
>>>>> +
>>>>> +    return offset;
>>>>> +}
>>>>> +
>>>>> static GPtrArray *alloc_list;
>>>>>=20
>>>>> static Aml *aml_alloc(void)
>>>>> diff --git a/include/hw/acpi/aml-build.h =
b/include/hw/acpi/aml-build.h
>>>>> index 559326c..dbf63cf 100644
>>>>> --- a/include/hw/acpi/aml-build.h
>>>>> +++ b/include/hw/acpi/aml-build.h
>>>>> @@ -385,6 +385,10 @@ int
>>>>> build_append_named_dword(GArray *array, const char *name_format, =
...)
>>>>> GCC_FMT_ATTR(2, 3);
>>>>>=20
>>>>> +int
>>>>> +build_append_named_qword(GArray *array, const char *name_format, =
...)
>>>>> +GCC_FMT_ATTR(2, 3);
>>>>> +
>>>>> void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t =
base,
>>>>>                        uint64_t len, int node, MemoryAffinityFlags =
flags);


--Apple-Mail=_4219616D-3493-43EC-A854-0093E45D96E4
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
CQUxDxcNMTcwMjA4MjAyNDExWjAjBgkqhkiG9w0BCQQxFgQU84smOb1qoZ77b5IFRuMagqRKwrIw
gcIGCSsGAQQBgjcQBDGBtDCBsTCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFu
Y2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxQTA/
BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVt
YWlsIENBAhEAljnjFZYn8wPj7xnx4zHsmzCBxAYLKoZIhvcNAQkQAgsxgbSggbEwgZsxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQg
QXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJY54xWWJ/MD4+8Z8eMx7JswDQYJ
KoZIhvcNAQEBBQAEggEAq0lZDtx/IFC5erycnSwAk9D//Ng9IJWXlNElSHf1H+GaeEROsED1Sl1M
J44usfCsd/NflEp5tgSXbJVx1yHKx+ry0PEkKlmzJQGPVjWNFLBPbYV+59fU1uZkC/TrF3dVMCTA
WN21tOTZdkUFerGyiTKf7Bkap24j23bw4jrbKWdtobcKIyJjWDp/ycdL0x3+XTBCANHKaZRkziUB
1ukaSRlF4a7UcOkMAHplPBDQtayQPEzK6TupPj2DtG6AwLgqQ0Ua3sbkT+lF1XqQv194owoKXWo7
4s5DWzkHp4g60vmHZN8dKyRLxMcoSgPtseUbTuAD0KrI9jTjKOXg2zfrVgAAAAAAAA==
--Apple-Mail=_4219616D-3493-43EC-A854-0093E45D96E4--
