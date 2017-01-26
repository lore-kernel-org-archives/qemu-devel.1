Received: from eggs.gnu.org ([2001:4830:134:3::10]:53685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cWciX-0000Ur-Fy
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 00:35:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cWciV-00061G-5w
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 00:35:29 -0500
Received: from mail-pf0-x232.google.com ([2607:f8b0:400e:c00::232]:34418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1cWciU-00060B-Mp
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 00:35:27 -0500
Received: by mail-pf0-x232.google.com with SMTP id e4so63305928pfg.1
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 21:35:25 -0800 (PST)
From: Ben Warren <ben@skyportsystems.com>
Message-Id: <6E25852D-224A-4BDC-AA83-8DC87DB4D0F0@skyportsystems.com>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_D817B422-54B2-4D0B-BDE5-70209762BA17";
	protocol="application/pkcs7-signature"; micalg=sha1
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date: Wed, 25 Jan 2017 21:35:21 -0800
In-Reply-To: <2497755c-8616-1f42-ff36-ad75f6778a52@redhat.com>
References: <cover.1485308342.git.ben@skyportsystems.com>
	<dabc5ffbb5b9d29e88087dcbe03b1ba0232c342c.1485308342.git.ben@skyportsystems.com>
	<827795cf-5399-7092-267e-e912141931f3@redhat.com>
	<29F9E21E-D768-47D8-8E7F-BBC9DC4F72DD@skyportsystems.com>
	<20170125202812-mutt-send-email-mst@kernel.org>
	<2497755c-8616-1f42-ff36-ad75f6778a52@redhat.com>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>


--Apple-Mail=_D817B422-54B2-4D0B-BDE5-70209762BA17
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On Jan 25, 2017, at 4:48 PM, Laszlo Ersek <lersek@redhat.com> wrote:
>=20
> On 01/25/17 19:35, Michael S. Tsirkin wrote:
>> On Wed, Jan 25, 2017 at 09:36:52AM -0800, Ben Warren wrote:
>>> Hi Laszlo,
>>>=20
>>>=20
>>>    On Jan 24, 2017, at 7:55 PM, Laszlo Ersek <lersek@redhat.com> =
wrote:
>>>=20
>>>    Hi Ben,
>>>=20
>>>    sorry about being late to reviewing this series. I hope I can now =
spend
>>>    more time on it.
>>>=20
>>>    - Please do not try to address my comments immediately. It's very
>>>    possible (even likely) that Igor, MST and myself could have =
different
>>>    opinions on things, so first please await agreement between your =
reviewers.
>>>=20
>>>=20
>>> Thanks for the very detailed review.  I=E2=80=99ll give it a couple =
of days and then
>>> start work on the suggested changes.
>>>=20
>>>=20
>>>    - I think you should have CC'd Igor and Michael directly. I'm =
adding
>>>    them to this reply; hopefully that will be enough for them to =
monitor
>>>    this series.
>>>=20
>>>    - I'll likely be unable to review everything with 100% coverage; =
so
>>>    addressing (or sufficiently refuting) my comments might not =
guarantee
>>>    that the next version will be merged at once.
>>>=20
>>>    With all that said:
>>>=20
>>>    On 01/25/17 02:43, ben@skyportsystems.com wrote:
>>>=20
>>>        From: Ben Warren <ben@skyportsystems.com>
>>>=20
>>>        This is initially used to patch a 64-bit address into the VM =
Generation
>>>        ID SSDT
>>>=20
>>>=20
>>>    (1) I think this commit message line is overlong; I think we wrap =
at 74
>>>    chars or so. Not critical, but worth mentioning.
>>>=20
>>>=20
>>>=20
>>>        Signed-off-by: Ben Warren <ben@skyportsystems.com>
>>>        ---
>>>        hw/acpi/aml-build.c         | 28 ++++++++++++++++++++++++++++
>>>        include/hw/acpi/aml-build.h |  4 ++++
>>>        2 files changed, 32 insertions(+)
>>>=20
>>>        diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
>>>        index b2a1e40..dc4edc2 100644
>>>        --- a/hw/acpi/aml-build.c
>>>        +++ b/hw/acpi/aml-build.c
>>>        @@ -285,6 +285,34 @@ build_append_named_dword(GArray *array, =
const char
>>>        *name_format, ...)
>>>            return offset;
>>>        }
>>>=20
>>>        +/*
>>>        + * Build NAME(XXXX, 0x00000000) where 0x00000000 is encoded =
as a
>>>        qword,
>>>        + * and return the offset to 0x00000000 for runtime patching.
>>>        + *
>>>        + * Warning: runtime patching is best avoided. Only use this =
as
>>>        + * a replacement for DataTableRegion (for guests that don't
>>>        + * support it).
>>>        + */
>>=20
>> only one comment: QWords first appeared in ACPI 2.0 and
>> XP does not like them. Not strictly a blocker as people can
>> avoid using the feature, but nice to have.
>=20
> Does XP have a driver for VMGENID?
>=20
> If not, then I'd prefer to stick with the qword VGIA.
>=20
>> Will either UEFI or seabios allocate
>> memory outside 4G range? If not you do not need a qword.
>=20
> Good point (assuming XP has a driver for VMGENID).
>=20
> OVMF keeps all such allocations (i.e., for COMMAND_ALLOCATE and the
> upcoming COMMAND_ALLOCATE_RETURN_ADDR) under 4GB, so as far as OVMF is
> concerned, using a dword for the VGIA named object should be fine.
> Accordingly, a 4-byte wide ADD_POINTER command should be used for
> patching VGIA.
>=20
> Considering the fw_cfg file that receives the address, and
> COMMAND_ALLOCATE_RETURN_ADDR more generally, I'd still prefer if those
> stayed 8-byte wide, regardless of XP's support for VMGENID.
>=20
>=20
> Hm... It looks like VMGENID *can* be consumed on Windows XP SP3, as =
long
> as "Hyper-V integration services" are installed:
>=20
> https://msdn.microsoft.com/en-us/library/jj643357(v=3Dvs.85).aspx =
<https://msdn.microsoft.com/en-us/library/jj643357(v=3Dvs.85).aspx>
>=20
>    The virtual machine must be running a guest operating system that
>    has support for the virtual machine generation identifier.
>    Currently, these are the following.
>    The following operating systems have native support for the virtual
>    machine generation identifier.
>      [...]
>=20
>    The following operating can be used as the guest operating system
>    if the Hyper-V integration services from Windows 8 or Windows
>    Server 2012 are installed.
>=20
>      [...]
>      * Windows XP with Service Pack 3 (SP3)
>=20
> Additionally, under
> <https://technet.microsoft.com/en-us/library/dn792027(v=3Dws.11).aspx =
<https://technet.microsoft.com/en-us/library/dn792027(v=3Dws.11).aspx>>:
>=20
>    Supported Windows client guest operating systems
>=20
>    Windows XP with       [...] Install the integration  [...]
>    Service Pack 3 (SP3)        services after you set
>                                up the operating system
>                                in the virtual machine.
>=20
> This seems to be consistent with the VMGENID spec requirement that the
> ADDR method return a package of two 32-bit integers, not a single =
64-bit
> one.
>=20
> So, I agree with using a dword for VGIA (and a matching 4-byte wide
> ADD_POINTER command).
>=20
> But, again, I'd like to keep COMMAND_ALLOCATE_RETURN_ADDR 8-byte wide.
> In the future we might introduce more allocation hints (for the "zone"
> field) that would enable the firmware to allocate from the full 64-bit
> address space.
>=20
> NB, I didn't check SeaBIOS (should be easy for Ben); AFAIR it only =
uses
> 16-bit and 32-bit modes.
>=20
Right, it appears that the allocated address will always fit in 32 bits. =
 As mentioned, XP should be OK since the ADDR method returns a package =
of two 32-bit numbers.

I propose to still include this patch but touch up the comments as =
requested by Laszlo.  This way it will be in the toolbox for future =
users and has been tested.  I will also change VGIA to dword and hard =
code the AML to return ADDR[1] =3D 0. =20

FYI: here=E2=80=99s an iasl dump from Windows 2012 Hyper-V in case you =
haven=E2=80=99t seen it.  Note that Microsoft uses E00 and violates the =
HID name length spec:

Scope (\_SB)
   {
       Device (GENC)
       {
           Name (_CID, "VM_Gen_Counter")  // _CID: Compatible ID
           Name (_HID, "Hyper_V_Gen_Counter_V1")  // _HID: Hardware ID
           Name (_UID, 0x00)  // _UID: Unique ID
           Name (_DDN, "VM_Gen_Counter")  // _DDN: DOS Device Name
           Method (ADDR, 0, NotSerialized)
           {
               Name (LPKG, Package (0x02)
               {
                   0x00,=20
                   0x00
               })
               LPKG [0x00] =3D GCAL /* \GCAL */
               LPKG [0x01] =3D GCAH /* \GCAH */
               Return (LPKG) /* \_SB_.GENC.ADDR.LPKG */
           }
       }
   }

   Scope (\_GPE)
   {
       Method (_E00, 0, NotSerialized)  // _Exx: Edge-Triggered GPE
       {
           Notify (\_SB.GENC, 0x80) // Status Change
       }
   }

> Thanks!
> Laszlo
>=20
>>=20
>>=20
>>=20
>>=20
>>>=20
>>>    (2) Since we're adding a qword (8-byte integer), the hexadecimal
>>>    constant should have 16 nibbles: 0x0000000000000000. (After =
copying the
>>>    comment from build_append_named_dword(), it should be =
actualized.)
>>>=20
>>>    (3) Normally the functions in this file that create AML operators =
carry
>>>    a note about the ACPI spec version and exact location that =
defines the
>>>    operator. I see that commit f20354910893 ("acpi: add
>>>    build_append_named_dword, returning an offset in buffer", =
2016-03-01)
>>>    missed that too.
>>>=20
>>>    Unless this tradition has been willfully abandoned, I suggest =
that you
>>>    add the right reference here, and also (in retrospect) to
>>>    build_append_named_dword().
>>>=20
>>>=20
>>>        +int
>>>        +build_append_named_qword(GArray *array, const char =
*name_format, ...)
>>>        +{
>>>        +    int offset;
>>>        +    va_list ap;
>>>        +
>>>        +    build_append_byte(array, 0x08); /* NameOp */
>>>        +    va_start(ap, name_format);
>>>        +    build_append_namestringv(array, name_format, ap);
>>>        +    va_end(ap);
>>>        +
>>>        +    build_append_byte(array, 0x0E); /* QWordPrefix */
>>>        +
>>>        +    offset =3D array->len;
>>>        +    build_append_int_noprefix(array, 0x00000000, 8);
>>>=20
>>>=20
>>>    (4) I guess the constant should be updated here too, for =
consistency
>>>    with the comment.
>>>=20
>>>    The rest looks okay. (I didn't verify 0x0E =3D=3D QWordPrefix =
specifically,
>>>    because an error there would break the functionality immediately, =
and
>>>    you'd notice.)
>>>=20
>>>    Thanks!
>>>    Laszlo
>>>=20
>>>=20
>>>        +    assert(array->len =3D=3D offset + 8);
>>>        +
>>>        +    return offset;
>>>        +}
>>>        +
>>>        static GPtrArray *alloc_list;
>>>=20
>>>        static Aml *aml_alloc(void)
>>>        diff --git a/include/hw/acpi/aml-build.h =
b/include/hw/acpi/aml-build.h
>>>        index 559326c..dbf63cf 100644
>>>        --- a/include/hw/acpi/aml-build.h
>>>        +++ b/include/hw/acpi/aml-build.h
>>>        @@ -385,6 +385,10 @@ int
>>>        build_append_named_dword(GArray *array, const char =
*name_format, ...)
>>>        GCC_FMT_ATTR(2, 3);
>>>=20
>>>        +int
>>>        +build_append_named_qword(GArray *array, const char =
*name_format, ...)
>>>        +GCC_FMT_ATTR(2, 3);
>>>        +
>>>        void build_srat_memory(AcpiSratMemoryAffinity *numamem, =
uint64_t base,
>>>                               uint64_t len, int node, =
MemoryAffinityFlags
>>>        flags);
>>>=20
>>>=20
>>> =E2=80=94Ben


--Apple-Mail=_D817B422-54B2-4D0B-BDE5-70209762BA17
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
CQUxDxcNMTcwMTI2MDUzNTIyWjAjBgkqhkiG9w0BCQQxFgQUZ8140xqlba+yqq0ZQ06gjO21Imgw
gcIGCSsGAQQBgjcQBDGBtDCBsTCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFu
Y2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxQTA/
BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVt
YWlsIENBAhEAljnjFZYn8wPj7xnx4zHsmzCBxAYLKoZIhvcNAQkQAgsxgbSggbEwgZsxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQg
QXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJY54xWWJ/MD4+8Z8eMx7JswDQYJ
KoZIhvcNAQEBBQAEggEAbHBqCEwyCyfdrq4gSqbw78B3Jw4/eIQ4wkpRZHaRmKSZZpgWNTQZtlL0
TgG23Yw+c0W4+7ENMdQHNnXrUxkyINmvlDlozfM6TBl76GGxTmd8xiXqCpg63G6vreqdgXQQ4u+N
ramYJPW5sp0pDVugjqGxqYqawElyq1upMUggWFN759RARiJQ5fiFxWP7iVUndoEHSjBBB9fn2JWU
2Ehgvc1lUqwAGWNrYb6sFXlSJBxATVbfmFNqN3zCPi745t0P83kcsOk1zsXUCh4cqFWxbBVyBaEp
rEbztaiNxtfSqPwyqRJZPdgXFG/y8smDSIi8FLyGATF1vgY0/pjIw8l0ZQAAAAAAAA==
--Apple-Mail=_D817B422-54B2-4D0B-BDE5-70209762BA17--
