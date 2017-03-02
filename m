Received: from eggs.gnu.org ([2001:4830:134:3::10]:38892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cjS4B-00048n-5I
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 09:50:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cjS49-0002oW-Pv
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 09:50:51 -0500
Received: from mail-ot0-x232.google.com ([2607:f8b0:4003:c0f::232]:36228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1cjS49-0002lZ-It
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 09:50:49 -0500
Received: by mail-ot0-x232.google.com with SMTP id i1so53526780ota.3
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 06:50:47 -0800 (PST)
From: Ben Warren <ben@skyportsystems.com>
Message-Id: <DA9B307F-F61C-428F-AEE4-5711E9033F8A@skyportsystems.com>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_F1F502F1-3BB0-425A-A707-AE772D3409FA";
	protocol="application/pkcs7-signature"; micalg=sha1
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date: Thu, 2 Mar 2017 06:50:45 -0800
In-Reply-To: <7938f647-6b1d-f8dd-feed-5ae7ce3c84cb@redhat.com>
References: <1488435591-17882-1-git-send-email-mst@redhat.com>
	<1488435591-17882-6-git-send-email-mst@redhat.com>
	<87a894m72h.fsf@dusky.pond.sub.org>
	<15694a65-6ac4-9387-1cc2-89d5bb8660b9@redhat.com>
	<87poi0hxxg.fsf@dusky.pond.sub.org>
	<7938f647-6b1d-f8dd-feed-5ae7ce3c84cb@redhat.com>
Subject: Re: [Qemu-devel] [PULL 05/15] qmp/hmp: add query-vm-generation-id
 and 'info vm-generation-id' commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>


--Apple-Mail=_F1F502F1-3BB0-425A-A707-AE772D3409FA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

I
> On Mar 2, 2017, at 5:15 AM, Laszlo Ersek <lersek@redhat.com> wrote:
>=20
> On 03/02/17 09:42, Markus Armbruster wrote:
>> Laszlo Ersek <lersek@redhat.com> writes:
>>=20
>>> On 03/02/17 09:11, Markus Armbruster wrote:
>>>> Crash bug, I'm afraid...
>>>>=20
>>>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>>>>=20
>>>>> From: Igor Mammedov <imammedo@redhat.com>
>>>>>=20
>>>>> Add commands to query Virtual Machine Generation ID counter.
>>>>>=20
>>>>> QMP command example:
>>>>>    { "execute": "query-vm-generation-id" }
>>>>>=20
>>>>> HMP command example:
>>>>>    info vm-generation-id
>>>>>=20
>>>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>>>> Signed-off-by: Ben Warren <ben@skyportsystems.com>
>>>>> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
>>>>> Tested-by: Laszlo Ersek <lersek@redhat.com>
>>>>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>>>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>>>> ---
>>>>> qapi-schema.json     | 20 ++++++++++++++++++++
>>>>> hmp.h                |  1 +
>>>>> hmp.c                |  9 +++++++++
>>>>> hw/acpi/vmgenid.c    | 16 ++++++++++++++++
>>>>> stubs/vmgenid.c      |  9 +++++++++
>>>>> hmp-commands-info.hx | 14 ++++++++++++++
>>>>> stubs/Makefile.objs  |  1 +
>>>>> 7 files changed, 70 insertions(+)
>>>>> create mode 100644 stubs/vmgenid.c
>>>>>=20
>>>>> diff --git a/qapi-schema.json b/qapi-schema.json
>>>>> index d6186d4..84692da 100644
>>>>> --- a/qapi-schema.json
>>>>> +++ b/qapi-schema.json
>>>>> @@ -6188,3 +6188,23 @@
>>>>> #
>>>>> ##
>>>>> { 'command': 'query-hotpluggable-cpus', 'returns': =
['HotpluggableCPU'] }
>>>>> +
>>>>> +##
>>>>> +# @GuidInfo:
>>>>> +#
>>>>> +# GUID information.
>>>>> +#
>>>>> +# @guid: the globally unique identifier
>>>>> +#
>>>>> +# Since: 2.9
>>>>> +##
>>>>> +{ 'struct': 'GuidInfo', 'data': {'guid': 'str'} }
>>>>> +
>>>>> +##
>>>>> +# @query-vm-generation-id:
>>>>> +#
>>>>> +# Show Virtual Machine Generation ID
>>>>> +#
>>>>> +# Since 2.9
>>>>> +##
>>>>> +{ 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
>>>> [...]
>>>>> diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
>>>>> index c8465df..744f284 100644
>>>>> --- a/hw/acpi/vmgenid.c
>>>>> +++ b/hw/acpi/vmgenid.c
>>>>> @@ -240,3 +240,19 @@ static void vmgenid_register_types(void)
>>>>> }
>>>>>=20
>>>>> type_init(vmgenid_register_types)
>>>>> +
>>>>> +GuidInfo *qmp_query_vm_generation_id(Error **errp)
>>>>> +{
>>>>> +    GuidInfo *info;
>>>>> +    VmGenIdState *vms;
>>>>> +    Object *obj =3D find_vmgenid_dev();
>>>>> +
>>>>> +    if (!obj) {
>>>>> +        return NULL;
>>>>> +    }
>>>>> +    vms =3D VMGENID(obj);
>>>>> +
>>>>> +    info =3D g_malloc0(sizeof(*info));
>>>>> +    info->guid =3D qemu_uuid_unparse_strdup(&vms->guid);
>>>>> +    return info;
>>>>> +}
>>>>=20
>>>> This either returns a GuidInfo or NULL.
>>>>=20
>>>> If it returns NULL, the generated qmp_marshal_output_GuidInfo() =
will
>>>> crash like this:
>>>>=20
>>>> #0  0x00007fffdb4c7765 in raise () at /lib64/libc.so.6
>>>> #1  0x00007fffdb4c936a in abort () at /lib64/libc.so.6
>>>> #2  0x00007fffdb4bff97 in __assert_fail_base () at /lib64/libc.so.6
>>>> #3  0x00007fffdb4c0042 in  () at /lib64/libc.so.6
>>>> #4  0x0000555555c800a0 in visit_start_struct (v=3D
>>>>    0x555557727000, name=3D0x555555cf29e8 "unused", =
obj=3D0x7fffffffc7c8, size=3D8, errp=3D0x7fffffffc790) at =
/work/armbru/qemu/qapi/qapi-visit-core.c:49
>>>> #5  0x0000555555c5d398 in visit_type_GuidInfo (v=3D
>>>>    0x555557727000, name=3D0x555555cf29e8 "unused", =
obj=3D0x7fffffffc7c8, errp=3D0x7fffffffc7d8) at qapi-visit.c:6038
>>>> #6  0x0000555555922fc0 in qmp_marshal_output_GuidInfo (ret_in=3D0x0, =
ret_out=3D0x7fffffffc870, errp=3D0x7fffffffc820) at qmp-marshal.c:5148
>>>> #7  0x0000555555923123 in qmp_marshal_query_vm_generation_id =
(args=3D0x555557a67500, ret=3D0x7fffffffc870, errp=3D0x7fffffffc868) at =
qmp-marshal.c:5186
>>>> #8  0x0000555555c83a73 in do_qmp_dispatch (request=3D0x555556ab3200, =
errp=3D0x7fffffffc8c0) at /work/armbru/qemu/qapi/qmp-dispatch.c:97
>>>> #9  0x0000555555c83ba3 in qmp_dispatch (request=3D0x555556ab3200)
>>>>    at /work/armbru/qemu/qapi/qmp-dispatch.c:124
>>>> #10 0x00005555557bb671 in handle_qmp_command (parser=3D
>>>>    0x5555568776b0, tokens=3D0x555556858520) at =
/work/armbru/qemu/monitor.c:3789
>>>> #11 0x0000555555c8af2f in json_message_process_token =
(lexer=3D0x5555568776b8, input=3D0x5555568582e0, type=3DJSON_RCURLY, =
x=3D48, y=3D1)
>>>>    at /work/armbru/qemu/qobject/json-streamer.c:105
>>>>=20
>>>> Sorry for not having reviewed this earlier.  On the other hand, how =
come
>>>> this survived testing?
>>>=20
>>> We primarily focused on testing the functionality, not the failure /
>>> corner cases, I think.
>>=20
>> That's as natural as it is wrong :)
>>=20
>> I'm a lackluster tester myself.  The only way I can bring myself to =
test
>> systematically is write automated tests.  Fortunately, our
>> infrastructure for that is much better than it used to be.  Our =
habits
>> still seem to be trailing the infrastructure, though.
>>=20
>> See also "New QMP command without a test -> automatic NAK", =
Message-ID:
>> <871sugkrw5.fsf@dusky.pond.sub.org>.
>>=20
>>>                       (There are at least two other known startup
>>> scenarios that are not handled correctly just yet, although they =
don't
>>> crash -- multiple vmgenid devices, and vmgenid on machtypes without
>>> writeable fw_cfg.)
>>>=20
>>> Also, in my testing I only called the monitor command via HMP (from
>>> virsh), and AFAICS that one doesn't crash even if the device is =
missing.
>>=20
>> Correct.
>>=20
>>> Nonetheless, qmp_query_vm_generation_id() should set an error when =
it
>>> returns NULL, yes.
>>=20
>> That's the obvious fix.  It's a one-liner.
>>=20
>>> I think Ben wants to post a followup series with those fixes =
mentioned
>>> above, in time for 2.9, perhaps this crash can be addressed in there
>>> too. Ben?
>>=20
>> Since the fix is a one-liner, I'd like you guys to consider =
respinning
>> this pull request with the fix.
>=20
> If Ben & Michael send out a new pull with the above fixed, I'd like to
> point out that the updated SeaBIOS blob is now in the tree (see commit
> 8779fccbef0c, "seabios: update to 1.10.2 release", 2017-02-28), so the
> unit test patch can be included as well.
>=20
Yes, the SeaBIOS image is now pulled in, so it=E2=80=99d be great to =
pull in the unit tests too.  What do I do here - send a patch with the =
fix, or a re-spin of the single original patch without the bug, or a =
re-spin of the patch series?
> Thanks
> Laszlo
>=20
>=20
=E2=80=94Ben


--Apple-Mail=_F1F502F1-3BB0-425A-A707-AE772D3409FA
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
CQUxDxcNMTcwMzAyMTQ1MDQ1WjAjBgkqhkiG9w0BCQQxFgQUW7NQmD6n8IMwOGcKzniK0N6hVKQw
gcIGCSsGAQQBgjcQBDGBtDCBsTCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFu
Y2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxQTA/
BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVt
YWlsIENBAhEAljnjFZYn8wPj7xnx4zHsmzCBxAYLKoZIhvcNAQkQAgsxgbSggbEwgZsxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQg
QXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJY54xWWJ/MD4+8Z8eMx7JswDQYJ
KoZIhvcNAQEBBQAEggEAmik4GRFuqaCy4LyLnWtNeMhTU8HR+39q0pGFew1R23T9SOjA0/uE6ebM
47hMrQcq8qrkZK+UmUi5GspzwbjdYDAkJrJAXe8WtncT4IZYsOBtLkD6cBiAgSjiz6/NttqbsWW+
IveuU83C7jDsn85jQaJy4okdyB/Rmpnbs2Z87jTFyoBjUmTMWUSH6C+HX5gE/GlfLYDlc5wadFAv
z1DiwVyC1VwxO2hd2P+hQ/3Mb5jvCW00Mhd8+NRrQS1SSEUOBosobOtktbhLwBT1gm1iDiSBvPtQ
Z+f43lJvjCWNb3HNCoiGqh7vImyCBG2h2KSOaoH/JMNuV7pfC1dD941CKQAAAAAAAA==
--Apple-Mail=_F1F502F1-3BB0-425A-A707-AE772D3409FA--
