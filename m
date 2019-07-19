Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76FEC76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 08:10:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4B422084D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 08:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=vmfacility.fr header.i=@vmfacility.fr header.b="O2BWf3WD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4B422084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoNyN-0003TB-V8
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 04:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45540)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ivan@vmfacility.fr>) id 1hoNy6-0002FI-7O
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 04:10:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ivan@vmfacility.fr>) id 1hoNy4-00074T-IG
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 04:10:18 -0400
Received: from db04.ivansoftware.com ([163.172.81.229]:52014)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ivan@vmfacility.fr>)
 id 1hoNy4-00072J-0E; Fri, 19 Jul 2019 04:10:16 -0400
Received: from [IPv6:2a01:cb19:678:2500:3dc4:a7cf:abac:5f67] (unknown
 [IPv6:2a01:cb19:678:2500:3dc4:a7cf:abac:5f67])
 by db04.ivansoftware.com (Postfix) with ESMTPSA id 3358DBE2B8D;
 Fri, 19 Jul 2019 10:10:14 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.2 at db04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vmfacility.fr;
 s=mail; t=1563523814;
 bh=1hq9/67ZVfUN8ih/XOpZeuxiaLGbLu8VLCOioNtj5GI=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=O2BWf3WDCvf18tP1X0sIbQFLtoxVsB2Ujeowg+c97qGgLt9AV1t7Fbh27ryaDkjuy
 BB5LmMSS1Ccimjmzn+P8I0c0aYUiRxLxuThyOG+OQuy2f8b7UrcA9WOSWPiIbXOtdk
 UNk7s2gcmn2jwuOuWRGGzwp48JEWSgEcatCFgnBPYMWJ4AH6uro4xRXkCJ2g570Xck
 y9rofUu5CVkJ8iw5c8Qe8M4XnkFTpZCkbZNsEARnz2kDy8l37KeiwXAzTy9SdSdteN
 FCHxR85gb2HGtUDNn9WsMJmBGTAyF5edwpWSuNEnkm3u8V8E0uVHgN0RvkE5UAm05I
 ifi8/m7u/fzhQ==
To: David Gibson <david@gibson.dropbear.id.au>
References: <c3466869-e259-fe38-c974-b3ccd349345f@vmfacility.fr>
 <20190718191911.3dcb39cb@bahia.lab.toulouse-stg.fr.ibm.com>
 <58ace4b9-3ed0-2658-a914-6a2cacb52fa9@vmfacility.fr>
 <20190719013413.GO8468@umbus.fritz.box>
Message-ID: <27d5dd4d-b911-ffb2-2663-718a3c472597@vmfacility.fr>
Date: Fri, 19 Jul 2019 10:10:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190719013413.GO8468@umbus.fritz.box>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="------------ms000707010104090605010300"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 163.172.81.229
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] Allow bit 15 to be set to 1 on
 slbmfee and slbmfev
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a cryptographically signed message in MIME format.

--------------ms000707010104090605010300
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: fr


Le 7/19/2019 =C3=A0 3:34 AM, David Gibson a =C3=A9crit=C2=A0:
> On Thu, Jul 18, 2019 at 10:15:52PM +0200, Ivan Warren wrote:
>> Le 7/18/2019 =C3=A0 7:19 PM, Greg Kurz a =C3=A9crit=C2=A0:
>>> We usually mention the subsystem name in the subject, ie.
>>>
>>> target/ppc: Allow bit 15 to be set to 1 on slbmfee and slbmfev
>> Gotcha ! Still learning the process as I go. Next time I submit someth=
ing,
>> I'll follow the guidelines more accurately.
>>> On Thu, 18 Jul 2019 14:44:49 +0200
>>> Ivan Warren <ivan@vmfacility.fr> wrote:
>>>
>>>> Allow bit 15 to be 1 in the slbmfee and slbmfev in TCG
>>>> as per Power ISA 3.0B (Power 9) Book III pages 1029 and 1030.
>>>> Per this specification, bit 15 is implementation specific
>>>> so it may be 1, but can probably ne safely ignored.
>> Another typo from me !
>>
>> s/ne safely/be safely/
>>
>>>> Power ISA 2.07B (Power 7/Power 8) indicates the bit is
>>>> reserved but some none Linux operating systems do set
>>> s/none Linux/non-Linux
>> Thanks ! Sorry for the typo !
>>>> this bit to 1 when entering the debugger.
>>>> So it is likely it is implemented on those systems
>>>> but wasn't yet documented.
>>>>
>>> ISA describes things that are common to several processor types,
>>> but each implementation may do some extra stuff... like giving
>>> a special meaning to an invalid instruction form for example (see
>>> commit fa200c95f7f99ce14b8af25ea0be478c722d3cec). This is supposed
>>> to be documented in the user manual.
>>>
>>> Maybe something similar was done with the reserved bit 15, even if I
>>> could fine no trace of that in the Power8 UM... of course. I'll try
>>> to find clues within IBM.
>>>
>>> https://openpowerfoundation.org/?resource_lib=3Dpower8-processor-user=
s-manual
>>>
>>> but it is indeed mentioned in the Power9 UM:
>>>
>>> https://openpowerfoundation.org/?resource_lib=3Dpower-processor-users=
-manual
>>>
>>> 4.10.7.2 SLB Management Instructions
>>>
>>> The POWER9 core implements the SLB management instructions as defined=
 in the
>>> Power ISA (Version 3.0B). Specifically, the following instruction det=
ails are
>>> noteworthy:
>>> =E2=80=A2 The slbmfee and slbmfev instructions can read any SLB entry=
 when UPRT =3D =E2=80=981=E2=80=99,
>>>     if the L-bit in the instruction image is set to a =E2=80=981=E2=80=
=99. This is an
>>>     implementation-specific feature that will only be used in the fut=
ure if and
>>>     when the POWER9 processor core supports UPRT =3D =E2=80=981=E2=80=
=99 for HPT translation.
>>>
>>> Not sure if we support that in TCG, but it doesn't hurt to relax the =
check
>>> if that's enough to make AIX's debugger happy.
>> Yep !
>>> Reviewed-by: Greg Kurz <groug@kaod.org>
>>>
>>>> Signed-off-by: Ivan Warren <ivan@vmfacility.fr>
>>>> ---
>>>>
>>>> The original creator of the patch is "Zhuowei Zhang"
>>>> (https://twitter.com/zhuowei) but I couldn't find any e-mail address=
=2E
>>>>
>>> This is the original patch, correct ?
>>>
>>> https://github.com/zhuowei/qemu/commit/c5f305c5d0cd336b2bb31cab8a70f9=
0b72905a1e
>> Indeed !
>>> After speaking with some QEMU folks on irc, it is okay to ignore the =
lack
>>> of S-o-b because the patch is trivial. But the general rule is to alw=
ays
>>> require an S-o-b when posting someone else's patch.
>> Is it good practice to add a S-o-b without the original author's conse=
nt
>> and/or without an e-mail address ?
> Absolutely not.

I thought as much (and why I didn't do it). However, I still wanted to=20
give credit (but not a "Signed-off-by:" tag since this didn't actually=20
occur) to the person who originally found the issue (and the fix). I=20
guess it should simply have been included in the commit log as a=20
comment, not as a comment in the patch submission message (between the=20
--- and the actual diff).

Anyway, I think the patch is sane and carries no systemic risk (it only=20
affects AIX KBD - and possibly other low level debuggers) - and there=20
are probably no PPC system that actually rely on those instructions=20
throwing an exception if this particular bit is not 0 !

>
>> Although I would very much doubt he would
>> have complained.
>>
>> Anyway, thanks for reviewing and for the tips ! (and sorry for all the=

>> noise).
>>
>>>>    =C2=A0target/ppc/translate.c | 4 ++--
>>>>    =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
>>>> index 4a5de28036..85f8b147ba 100644
>>>> --- a/target/ppc/translate.c
>>>> +++ b/target/ppc/translate.c
>>>> @@ -7064,8 +7064,8 @@ GEN_HANDLER2(mtsr_64b, "mtsr", 0x1F, 0x12, 0x0=
6,
>>>> 0x0010F801, PPC_SEGMENT_64B),
>>>>    =C2=A0GEN_HANDLER2(mtsrin_64b, "mtsrin", 0x1F, 0x12, 0x07, 0x001F=
0001,
>>>>    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 PPC_SEGMENT_64B),
>>>>    =C2=A0GEN_HANDLER2(slbmte, "slbmte", 0x1F, 0x12, 0x0C, 0x001F0001=
,
>>>> PPC_SEGMENT_64B),
>>>> -GEN_HANDLER2(slbmfee, "slbmfee", 0x1F, 0x13, 0x1C, 0x001F0001,
>>>> PPC_SEGMENT_64B),
>>>> -GEN_HANDLER2(slbmfev, "slbmfev", 0x1F, 0x13, 0x1A, 0x001F0001,
>>>> PPC_SEGMENT_64B),
>>>> +GEN_HANDLER2(slbmfee, "slbmfee", 0x1F, 0x13, 0x1C, 0x001E0001,
>>>> PPC_SEGMENT_64B),
>>>> +GEN_HANDLER2(slbmfev, "slbmfev", 0x1F, 0x13, 0x1A, 0x001E0001,
>>>> PPC_SEGMENT_64B),
>>>>    =C2=A0GEN_HANDLER2(slbfee_, "slbfee.", 0x1F, 0x13, 0x1E, 0x001F00=
00,
>>>> PPC_SEGMENT_64B),
>>>>    =C2=A0#endif
>>>>    =C2=A0GEN_HANDLER(tlbia, 0x1F, 0x12, 0x0B, 0x03FFFC01, PPC_MEM_TL=
BIA),
>
>


--------------ms000707010104090605010300
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
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MDcxOTA4MTAxMFowLwYJKoZIhvcNAQkE
MSIEIBprOfWbJ1epOwAPzxrKvQczikrqIyhRA2Mu5GbAfFl1MGwGCSqGSIb3DQEJDzFfMF0w
CwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAw
DQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwgbwGCSsGAQQBgjcQBDGB
rjCBqzCBljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4G
A1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0
aWdvIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQAUsx
i7HsmGkuUPsvFswztzCBvgYLKoZIhvcNAQkQAgsxga6ggaswgZYxCzAJBgNVBAYTAkdCMRsw
GQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoT
D1NlY3RpZ28gTGltaXRlZDE+MDwGA1UEAxM1U2VjdGlnbyBSU0EgQ2xpZW50IEF1dGhlbnRp
Y2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEAFLMYux7JhpLlD7LxbMM7cwDQYJKoZIhvcN
AQEBBQAEggEAsjvITNNXVUyNIv3XZejoXaR2pL6p313wjqwUcbPMmqJG9e/gj748f58xo+cp
fIMKNe5B4OXG5vkxmHPjPnyRimqSU6PjaP8G/Bva4t16MdUxJCFAK7cowsDHMYTEGXn8L3uW
wguc+oRruuL4w0cSWIDuXJ84lN/cZi5GuKwgSUqDLSbF5zt0wb25nlx0u72dTxBA1aRU6t1m
6vDWtSZhj8V9xSR69Az+ywE78CsHZkiKvqnurK+ZJJqj0hdHr2bjihRYbArOh0kukyxOFQGD
3UnhkJJwyf/1b1L4rQ3FwPtCBM0qfH8n4wP0GhrZhlBmedEu+ZRAJjNtJOg2UbdDgwAAAAAA
AA==
--------------ms000707010104090605010300--

