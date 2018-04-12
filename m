Received: from eggs.gnu.org ([2001:4830:134:3::10]:47635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <darrell.leinwand@psware.com>) id 1f6S7f-0002Kk-S5
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 22:38:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <darrell.leinwand@psware.com>) id 1f6S7a-0001uQ-SM
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 22:38:03 -0400
From: Darrell Leinwand <darrell.leinwand@psware.com>
Date: Thu, 12 Apr 2018 02:37:52 +0000
Message-ID: <09D6C852-DF1C-4179-B5D6-D2FDEBA9FE0D@psware.com>
References: <222EDB99-2ED5-4CCB-B550-7A02BC4BDC7F@psware.com>
	<c8484d2f-bc72-5e6d-d0a2-d3900a4b25ae@linaro.org>
In-Reply-To: <c8484d2f-bc72-5e6d-d0a2-d3900a4b25ae@linaro.org>
Content-Language: en-US
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
	micalg=sha256; boundary="B_3606320271_1387640584"
MIME-Version: 1.0
Subject: Re: [Qemu-devel] Bad icount read when running qemu-system-ppc64 and
 mfspr atbu guest instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>

--B_3606320271_1387640584
Content-type: text/plain;
	charset="UTF-8"
Content-transfer-encoding: quoted-printable

Ah I see, that makes sense and the atb instructions are marked as unused in=
 the mainline which when I compared I recall now that we modifed them becaus=
e the guest software we are running is trying to use those special registers=
.=20

I added the wrappers into those function, is that correct?

Thanks for the help.

Darrell

=EF=BB=BFOn 4/11/18, 4:39 PM, "Richard Henderson" <richard.henderson@linaro.org> =
wrote:

    On 04/12/2018 04:18 AM, Darrell Leinwand wrote:
    > Hi,
    >=20
    > When I enable icount using an e5500 core I get an exit with =E2=80=9CBad ic=
ount
    > read=E2=80=9D when the guest software executes a load atbu command.
   =20
    Yep, it looks like there are some bugs in the ppc front end wrt icount.
   =20
    In target/ppc/translate_init.c, spr_read_tbu has the proper wrappers fo=
r
    integrating with icount, but a few lines lower spr_read_atbl and spr_re=
ad_atbu
    do not.
   =20
    This will probably have to wait until the 2.13 cycle to fix...
   =20
   =20
    r~
   =20
   =20
    PS:
   =20
    >=20
    > CONFIDENTIALITY NOTICE: The information contained in this e-mail and =
any accompanying documents may contain information that is confidential, pro=
prietary to Performance Software, or otherwise protected from disclosure. If=
 you are not the intended recipient of this message, or if this message has =
been addressed to you in error, please immediately alert the sender by reply=
 e-mail and then delete this message, including any attachments. Any dissemi=
nation, distribution or other use of the contents of this message by anyone =
other than the intended recipient is strictly prohibited.
    >=20
   =20
    You really should strip this from your signature when posting to a publ=
ic list.
   =20

--B_3606320271_1387640584
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIUGwYJKoZIhvcNAQcCoIIUDDCCFAgCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0B
BwGgghH7MIIF/jCCBOagAwIBAgIQQAFbtm3GSaAKRoW+3OzQZTANBgkqhkiG9w0BAQsFADA6
MQswCQYDVQQGEwJVUzESMBAGA1UEChMJSWRlblRydXN0MRcwFQYDVQQDEw5UcnVzdElEIENB
IEExMjAeFw0xNzA0MjgyMTE4MTlaFw0xODA0MjgyMTE4MTlaMIGTMTQwMgYDVQQLDCtWZXJp
ZmllZCBFbWFpbDogZGFycmVsbC5sZWlud2FuZEBwc3dhcmUuY29tMSowKAYJKoZIhvcNAQkB
FhtkYXJyZWxsLmxlaW53YW5kQHBzd2FyZS5jb20xLzAtBgoJkiaJk/IsZAEBEx9BMDE0MjdF
MDAwMDAxNUJCNjZEQzYxQTAwMDA4QTE5MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAtDENQk32eVeJ+owIpbqNp8oaQOnpS47EM4MkEN038KE1k/PIbt49IvYOP9fxL3Aj+qpI
Fgag2u7hqoaehGfQyEP+y0TpCD1yIaGRyn/tNI1BBgtzsGRUajGzFpZPYbiLunz4rgL8tnoi
38md+rYXn/ZlvMjW/h2FNbOnMc8ZyxaUN7ZBt7gwrvrUse9rWIR7dOmL/KfZtb8jh8ETxcD/
yPbVr+jCRC87pW88pGLHfeUAk4tyEWMLDCWEaz1QsyqWXFx35ai7Zf8CDYrUgnxabo4KaWcv
LPDotZMHNmFHdxQGsheIc87lWyBBty5sL8b3shVe+KvEFp5fasl8VRNctwIDAQABo4ICpDCC
AqAwDgYDVR0PAQH/BAQDAgWgMIGEBggrBgEFBQcBAQR4MHYwMAYIKwYBBQUHMAGGJGh0dHA6
Ly9jb21tZXJjaWFsLm9jc3AuaWRlbnRydXN0LmNvbTBCBggrBgEFBQcwAoY2aHR0cDovL3Zh
bGlkYXRpb24uaWRlbnRydXN0LmNvbS9jZXJ0cy90cnVzdGlkY2FhMTIucDdjMB8GA1UdIwQY
MBaAFKRz2u9pNYp1zKAZewgy+GuJ5ELsMAkGA1UdEwQCMAAwggEsBgNVHSAEggEjMIIBHzCC
ARsGC2CGSAGG+S8ABgsBMIIBCjBKBggrBgEFBQcCARY+aHR0cHM6Ly9zZWN1cmUuaWRlbnRy
dXN0LmNvbS9jZXJ0aWZpY2F0ZXMvcG9saWN5L3RzL2luZGV4Lmh0bWwwgbsGCCsGAQUFBwIC
MIGuGoGrVGhpcyBUcnVzdElEIENlcnRpZmljYXRlIGhhcyBiZWVuIGlzc3VlZCBpbiBhY2Nv
cmRhbmNlIHdpdGggCklkZW5UcnVzdCdzIFRydXN0SUQgQ2VydGlmaWNhdGUgUG9saWN5IGZv
dW5kIGF0IGh0dHBzOi8vc2VjdXJlLmlkZW50cnVzdC5jb20vY2VydGlmaWNhdGVzL3BvbGlj
eS90cy9pbmRleC5odG1sMEUGA1UdHwQ+MDwwOqA4oDaGNGh0dHA6Ly92YWxpZGF0aW9uLmlk
ZW50cnVzdC5jb20vY3JsL3RydXN0aWRjYWExMi5jcmwwJgYDVR0RBB8wHYEbZGFycmVsbC5s
ZWlud2FuZEBwc3dhcmUuY29tMB0GA1UdDgQWBBQAunEGqSOXhPKvoUUIaBHT36IpgzAdBgNV
HSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwDQYJKoZIhvcNAQELBQADggEBAIsjZV9QPA8m
VjcpwmrwtMknyncExI5Ox0kMoz0avEcTGog26snykEwQs9cM028x5Ic5/NOcMlyxGNHtKVag
tHj74W9I+26dq46ykWeWt0bjE1GK7jlEL3fwmlsRzdB5oFq5JbalSqh/RGqN7YA+YuHu5ovx
NEJKFCAqblCRhkKU01+wOoIYOXj6F+OHx92mfNF1cvsgVrdNt6m8CL/xgEGUuWzjjM+251YL
ZVuN3v+8arDloqnY19uvaUC6+TtPhTCns8hjjADmai0wqMenJQlW5tP+38vjhpZb/FcgrHHf
uP4JlpH6/h20PWG5h+hWQdyLj0Acccx8ahoBLwEAG9IwggaRMIIEeaADAgECAhEA+d5Wf8lN
DHdw+WAbUtoVOzANBgkqhkiG9w0BAQsFADBKMQswCQYDVQQGEwJVUzESMBAGA1UEChMJSWRl
blRydXN0MScwJQYDVQQDEx5JZGVuVHJ1c3QgQ29tbWVyY2lhbCBSb290IENBIDEwHhcNMTUw
MjE4MjIyNTE5WhcNMjMwMjE4MjIyNTE5WjA6MQswCQYDVQQGEwJVUzESMBAGA1UEChMJSWRl
blRydXN0MRcwFQYDVQQDEw5UcnVzdElEIENBIEExMjCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBANGRTTzPCic0kq5L6ZrUJWt5LE/n6tbPXPhGt2Egv7plJMoEpvVJJDqGqDYy
maAsd8Hn9ZMAuKUEFdlx5PgCkfu7jL5zgiMNnAFVD9PyrsuF+poqmlxhlQ06sFY2hbhQkVVQ
00KCNgUzKcBUIvjv04w+fhNPkwGW5M7Ae5K5OGFGwOoRck9GG6MUVKvTNkBw2/vNMOd29VGV
TtR0tjH5PS5yDXss48Yl1P4hDStO2L4wTsW2P37QGD27//XGN8K6amWB6F2XOgff/PmlQjQO
ORT95PmLkwwvma5nj0AS0CVp8kv0K2RHV7GonllKpFDMT0CkxMQKwoj+tWEWJTiDKSsCAwEA
AaOCAoAwggJ8MIGJBggrBgEFBQcBAQR9MHswMAYIKwYBBQUHMAGGJGh0dHA6Ly9jb21tZXJj
aWFsLm9jc3AuaWRlbnRydXN0LmNvbTBHBggrBgEFBQcwAoY7aHR0cDovL3ZhbGlkYXRpb24u
aWRlbnRydXN0LmNvbS9yb290cy9jb21tZXJjaWFscm9vdGNhMS5wN2MwHwYDVR0jBBgwFoAU
7UQZwNPwBovupHu+QucmVMiONnYwDwYDVR0TAQH/BAUwAwEB/zCCASAGA1UdIASCARcwggET
MIIBDwYEVR0gADCCAQUwggEBBggrBgEFBQcCAjCB9DBFFj5odHRwczovL3NlY3VyZS5pZGVu
dHJ1c3QuY29tL2NlcnRpZmljYXRlcy9wb2xpY3kvdHMvaW5kZXguaHRtbDADAgEBGoGqVGhp
cyBUcnVzdElEIENlcnRpZmljYXRlIGhhcyBiZWVuIGlzc3VlZCBpbiBhY2NvcmRhbmNlIHdp
dGggSWRlblRydXN0J3MgVHJ1c3RJRCBDZXJ0aWZpY2F0ZSBQb2xpY3kgZm91bmQgYXQgaHR0
cHM6Ly9zZWN1cmUuaWRlbnRydXN0LmNvbS9jZXJ0aWZpY2F0ZXMvcG9saWN5L3RzL2luZGV4
Lmh0bWwwSgYDVR0fBEMwQTA/oD2gO4Y5aHR0cDovL3ZhbGlkYXRpb24uaWRlbnRydXN0LmNv
bS9jcmwvY29tbWVyY2lhbHJvb3RjYTEuY3JsMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEF
BQcDBDAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0OBBYEFKRz2u9pNYp1zKAZewgy+GuJ5ELsMA0G
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
bw6Aun3zShMhOXLZ1dmtelLySnWQ

--B_3606320271_1387640584--
