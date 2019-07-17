Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECF6C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 06:44:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C0442173B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 06:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=vmfacility.fr header.i=@vmfacility.fr header.b="nkD6BTqP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C0442173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hndfe-0001ei-Qj
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 02:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43342)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ivan@vmfacility.fr>) id 1hndfT-0001As-S3
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 02:44:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ivan@vmfacility.fr>) id 1hndfS-0007Pj-Q3
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 02:43:59 -0400
Received: from db04.iswnet.net ([2001:bc8:3515:300::1]:57540
 helo=db04.ivansoftware.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ivan@vmfacility.fr>)
 id 1hndfS-0007Lu-1o; Wed, 17 Jul 2019 02:43:58 -0400
Received: from [192.168.1.19] (lfbn-1-11114-172.w86-213.abo.wanadoo.fr
 [86.213.193.172])
 by db04.ivansoftware.com (Postfix) with ESMTPSA id 5044ABE2B24;
 Wed, 17 Jul 2019 08:43:54 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.2 at db04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vmfacility.fr;
 s=mail; t=1563345834;
 bh=QNWbX4Eb84cOxvtu6dIC4NLFC5P7oTLa08cWylZ/DHc=;
 h=To:Cc:From:Subject:Date:From;
 b=nkD6BTqPB1Gsrsj6qMfHb4ZtFn35U2nvZgyLC9xpWQr5FJZmfZB1gfY7qG6WMZVyq
 M2bm9uVpl12u1kUFq53LS2E1jSylWsTQ4iBeUydgRV9HSXlJ+v2uw9uV+pbpzdGJET
 PaHLkgQaK62T4zrJHZnuYFpHiMSxhZIXwkmEDyRzO8T/SuQO/LNUqN1Vgjqmq7+5AJ
 HRL/CPMXWNMHrPEB152FbVWuoymWmqpTDdwmkqRoYXrqMrySLTk2fKbNXJyXuLGkAq
 3z/zCVqOPy6jcb/dGZkmPrglcDsVDsCibWBxrcHawlUPYwRH0z2zX+WoAv/wHpl97L
 74wo8JeZNFiSA==
To: qemu-ppc@nongnu.org
Message-ID: <b9bdbb6e-2ee5-c8ce-92a6-0eea5586f2b6@vmfacility.fr>
Date: Wed, 17 Jul 2019 08:43:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="------------ms010103010706010606060906"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:bc8:3515:300::1
Subject: [Qemu-devel] Allow Bit 15 in slbmfee and slbmfev per Power ISA
 3.02B Book III pages 1299 and 1300
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
From: Ivan Warren via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Ivan Warren <ivan@vmfacility.fr>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a cryptographically signed message in MIME format.

--------------ms010103010706010606060906
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: fr

My previous message might have felt through the cracks due to some=20
improper formating.

****************************

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 4a5de28036..85f8b147ba 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7064,8 +7064,8 @@ GEN_HANDLER2(mtsr_64b, "mtsr", 0x1F, 0x12, 0x06,=20
0x0010F801, PPC_SEGMENT_64B),
 =C2=A0GEN_HANDLER2(mtsrin_64b, "mtsrin", 0x1F, 0x12, 0x07, 0x001F0001,
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 PPC_SEGMENT_64B),
 =C2=A0GEN_HANDLER2(slbmte, "slbmte", 0x1F, 0x12, 0x0C, 0x001F0001,=20
PPC_SEGMENT_64B),
-GEN_HANDLER2(slbmfee, "slbmfee", 0x1F, 0x13, 0x1C, 0x001F0001,=20
PPC_SEGMENT_64B),
-GEN_HANDLER2(slbmfev, "slbmfev", 0x1F, 0x13, 0x1A, 0x001F0001,=20
PPC_SEGMENT_64B),
+GEN_HANDLER2(slbmfee, "slbmfee", 0x1F, 0x13, 0x1C, 0x001E0001,=20
PPC_SEGMENT_64B),
+GEN_HANDLER2(slbmfev, "slbmfev", 0x1F, 0x13, 0x1A, 0x001E0001,=20
PPC_SEGMENT_64B),
 =C2=A0GEN_HANDLER2(slbfee_, "slbfee.", 0x1F, 0x13, 0x1E, 0x001F0000,=20
PPC_SEGMENT_64B),
 =C2=A0#endif
 =C2=A0GEN_HANDLER(tlbia, 0x1F, 0x12, 0x0B, 0x03FFFC01, PPC_MEM_TLBIA),

****************************

If this is already being considered, please disregard,

--Ivan



--------------ms010103010706010606060906
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: Signature cryptographique S/MIME

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
CykwggURMIID+aADAgECAhABSzGLseyYaS5Q+y8WzDO3MA0GCSqGSIb3DQEBCwUAMIGWMQsw
CQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxm
b3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENs
aWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTE5MDcwNDAwMDAw
MFoXDTIyMDcwMzIzNTk1OVowIzEhMB8GCSqGSIb3DQEJARYSaXZhbkB2bWZhY2lsaXR5LmZy
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA16J+MNpaqIEV5b2WoLC+l2PP5n3W
CtXrhU04ursB8Ib+TIGaJQQigdKp2pX7xwY9F/h1vukcYHNxILOvpop8AYyFbCMwmh0r2vZs
hDpYA1adv7wGsL3tbV155FTk0RewY8//18CaQ/SwVMRiUtqwbsUlbHkHtQRm32r/Otpzjd4/
vcTshpsPRIcxEib2UMRP6WGjHurC4rd/3pcWlP/GsjA/aGNb9yaNunHBTJzVaqSeiwwYObco
sJi1199wNBePGrZK6WF3XumgA6++kTKEieJ6hSj2amTR80VaYIzKyjCu4SklI7+ouBL/8UsN
ljRrIL8sCLkyBlYjWYNsQR3ZbQIDAQABo4IByzCCAccwHwYDVR0jBBgwFoAUCcDy/AvalNtf
/ivfqJlCz8ngrQAwHQYDVR0OBBYEFEmwhbO6wfSTbflKHMQwSp7HWMGvMA4GA1UdDwEB/wQE
AwIFoDAMBgNVHRMBAf8EAjAAMB0GA1UdJQQWMBQGCCsGAQUFBwMEBggrBgEFBQcDAjBABgNV
HSAEOTA3MDUGDCsGAQQBsjEBAgEBATAlMCMGCCsGAQUFBwIBFhdodHRwczovL3NlY3RpZ28u
Y29tL0NQUzBaBgNVHR8EUzBRME+gTaBLhklodHRwOi8vY3JsLnNlY3RpZ28uY29tL1NlY3Rp
Z29SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0EuY3JsMIGKBggrBgEF
BQcBAQR+MHwwVQYIKwYBBQUHMAKGSWh0dHA6Ly9jcnQuc2VjdGlnby5jb20vU2VjdGlnb1JT
QUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcnQwIwYIKwYBBQUHMAGG
F2h0dHA6Ly9vY3NwLnNlY3RpZ28uY29tMB0GA1UdEQQWMBSBEml2YW5Adm1mYWNpbGl0eS5m
cjANBgkqhkiG9w0BAQsFAAOCAQEAPXjOtK7xHfpAU3HUn5hIlaWUzkbaMI1R8tiefaJsHJks
4dkh/IqQhI+3yCjPybY38NP+ctwgpOZo7ARK/lLKo4+yooYs+5MrwCvP2Kw2RKPp+ZjhJIWX
DVcoVUxkONrVJH/VuTB3zeJDZ9nrODK9D3X1W2+8srQKgDjlx0sLYuBQEwNDEft9Ag9rL4/5
X1nlZJZbR8KWM0BxpHYTi7iGL2Gk8GE+beHDmyCAJHolkcs6G3GXwsp03hm300PGbEVsuWgA
5zHW90OSi/5CnrN15TaOC2yd9nRsobe5ajJAUjvCyVrl+tLmiM/KYJ24/R5Mb+CF6HhhiUa4
IwbWGZZbgzCCBhAwggP4oAMCAQICEE2ULBDUO+CUCcWBLTorBk8wDQYJKoZIhvcNAQEMBQAw
gYgxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpOZXcgSmVyc2V5MRQwEgYDVQQHEwtKZXJzZXkg
Q2l0eTEeMBwGA1UEChMVVGhlIFVTRVJUUlVTVCBOZXR3b3JrMS4wLAYDVQQDEyVVU0VSVHJ1
c3QgUlNBIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4XDTE4MTEwMjAwMDAwMFoXDTMwMTIz
MTIzNTk1OVowgZYxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIx
EDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoTD1NlY3RpZ28gTGltaXRlZDE+MDwGA1UEAxM1
U2VjdGlnbyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0Ew
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDKPO2UCkH/3vlGuejWO+bakr8rEE6q
GryCvb4mHCkqKtLNnFCBP22ULvOXqGfV9eNKjkypdR8i0yW2sxpepwRIm4rx20rno0JKuriI
Mpoqr03E5cWapdfbM3wccaNDZvZe/S/Uvk2TUxA8oDX3F5ZBykYQYVRR3SQ36gejH4v1pXWu
N82IKPdsmTqQlo49ps+LbnTeef8hNfl7xZ8+cbDhW5nv0qGPVgGt/biTkR7WwtMewu2mIr06
MbiJBEF2rpn9OVXH+EYB7PmHfpsEkzGp0cul3AhSROpPyx7d53Q97ANyH/yQc+jl9mXm7UHR
5ymr+wM3/mwIbnYOz5BTk7kTAgMBAAGjggFkMIIBYDAfBgNVHSMEGDAWgBRTeb9aqitKz1SA
4dibwJ3ysgNmyzAdBgNVHQ4EFgQUCcDy/AvalNtf/ivfqJlCz8ngrQAwDgYDVR0PAQH/BAQD
AgGGMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwME
MBEGA1UdIAQKMAgwBgYEVR0gADBQBgNVHR8ESTBHMEWgQ6BBhj9odHRwOi8vY3JsLnVzZXJ0
cnVzdC5jb20vVVNFUlRydXN0UlNBQ2VydGlmaWNhdGlvbkF1dGhvcml0eS5jcmwwdgYIKwYB
BQUHAQEEajBoMD8GCCsGAQUFBzAChjNodHRwOi8vY3J0LnVzZXJ0cnVzdC5jb20vVVNFUlRy
dXN0UlNBQWRkVHJ1c3RDQS5jcnQwJQYIKwYBBQUHMAGGGWh0dHA6Ly9vY3NwLnVzZXJ0cnVz
dC5jb20wDQYJKoZIhvcNAQEMBQADggIBAEFEdQCrOcIV9d6OlW0ycWiMAN0X13ocEDiQyOOx
vRcxkfO244K0oX7GzCGHYaqRbklCszzNWVT4DZU/vYrLaeVEDUbCYg+Ci7vhNn9dNqscbzN0
xKBoOuRVjPPWDechU70geT3pXCxpwi8EXwl+oiz7xpYfY99JSs3E/piztTSxljHitcPr5yoW
r9lbkFR8KU3+uGTZ11BfKfuSSaRrZFBv133SeY0d2AqvB9Dj2ZDaFZA0OQkkhfAqNgDpVRH9
9lQV4JSKx0N7/QAEtMj6OF5dRXV6hhXuU3A0Eql4d0247oBpxvnfcmV95QfG8HP059hZSJe7
T2wwC+IzXVDQO4xnnvrQJ07ZWemxc/grFpgiG+o+pQxapF1bKftysi02Rl6uhdp5wbTeLeYz
t2SI9oKSChwGDQQFixtkNnxuwbdrTwvASwvViDPdIGzIQJrTBqriE5/9nzkXbDZmld8/7Dyr
iJ/A73RIZllX4dH8mHqsRpU8NEX8IQZWpHWGK5A5nVgvl7MxNfRlIvCvKZQTSnCL8oNqJgHX
m6zCB4gBwDonM8V/2kuQAUVazVA3I376eIWGwzjuqh3H88v7mNHzubLHm5h0ERCSQNz6UoHV
Zy3q5xeqbYSaxpDQz3lCNObL6sNaOQNh3DcyzqZJYTcGfuLlmC3AIteAAh7lbybJszYnMYIE
MjCCBC4CAQEwgaswgZYxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0
ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoTD1NlY3RpZ28gTGltaXRlZDE+MDwGA1UE
AxM1U2VjdGlnbyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwg
Q0ECEAFLMYux7JhpLlD7LxbMM7cwDQYJYIZIAWUDBAIBBQCgggJXMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MDcxNzA2NDM1M1owLwYJKoZIhvcNAQkE
MSIEILh5CNAZooGgUj+UtOc2PTB5c89gkhFm+75qxE/v76tEMGwGCSqGSIb3DQEJDzFfMF0w
CwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAw
DQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwgbwGCSsGAQQBgjcQBDGB
rjCBqzCBljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4G
A1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0
aWdvIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQAUsx
i7HsmGkuUPsvFswztzCBvgYLKoZIhvcNAQkQAgsxga6ggaswgZYxCzAJBgNVBAYTAkdCMRsw
GQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoT
D1NlY3RpZ28gTGltaXRlZDE+MDwGA1UEAxM1U2VjdGlnbyBSU0EgQ2xpZW50IEF1dGhlbnRp
Y2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEAFLMYux7JhpLlD7LxbMM7cwDQYJKoZIhvcN
AQEBBQAEggEAooqRRQsIJFK7m8kz05LYvAHhBROZPUEjOAz/Me1hGhVdWcuRfvEsPUghA5RG
i7J3L8sPMUOUsAkgIEpKnsf3qa/o9NtPqJtQQFF3lMajboWKNiEG9BeyL5i2Xp4FJhjlc3jF
pb/9hPSz1mFIEusSgL3bHpAkhsegUHNVgY94hgV/HpRvIL9tE7Q0Wp2kqN37mQ1AfQIXD7K0
Eq7Vg6jVt0jmzrSnoX5c3vo6AHk67tyuZfp/qDXJZOqUNobmHrfK1Vda3QPyE2sHiQ0teiP9
iwZaFwy8lxj3YgnHOdXu/b4jdoylHJQJJSlSAEs3eY6ZmXMqh5j/zCAGDTCpaG+dEwAAAAAA
AA==
--------------ms010103010706010606060906--

