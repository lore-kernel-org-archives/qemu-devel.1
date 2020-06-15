Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3260FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 13:15:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B49E2074D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 13:15:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B49E2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkoxf-0004Ve-6I
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 09:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jkox3-00042k-0K
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 09:15:01 -0400
Resent-Date: Mon, 15 Jun 2020 09:15:01 -0400
Resent-Message-Id: <E1jkox3-00042k-0K@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21718)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jkox0-0001wo-JR
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 09:15:00 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1592226884; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=araJtoibIaUsajO5cZmFYlTR34b/mHegy2YPVGzXz7yx2JRi/cO0RPzMsolqjjMN1vV6YyewbNI12XeTc8f/4EqQXbFyymedgiPOBqpevTKTSS9m575UxULDRaUxmUDaYAACSZO7lwKQZJ8lE1ZgkS/hsL9z/NlYjwjcIWh7uYw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1592226884;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=1NymkzB1cHPORq4L5Y+hYE8sPIPP+LypIWCkk3jzp3A=; 
 b=D4LKfbMYTOVdp2gY3U5SG04Cnf93W/mBs+0eIKy3WMQdrisQC+DvaJ5tGvr0Hni2PPFkPKsgzZQZy5qlRvRLMBW57+vbz/glSz/L5F2tHAGpZJhr5/7Zp4ic24SbVxdbuplG8LVZUcm7BrGX+KQ+6AK+op+D+dWreZHDJGxBQjk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1592226881523863.5773104480271;
 Mon, 15 Jun 2020 06:14:41 -0700 (PDT)
Message-ID: <159222687990.71.204407911298751142@d1fd068a5071>
Subject: Re: [PATCH 0/3] tpm: Enable usage of TPM TIS with interrupts
In-Reply-To: <20200615123700.242259-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: stefanb@linux.vnet.ibm.com
Date: Mon, 15 Jun 2020 06:14:41 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 09:14:54
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Reply-To: qemu-devel@nongnu.org
Cc: stefanb@linux.vnet.ibm.com, qemu-devel@nongnu.org, eric.auger@redhat.com,
 marcandre.lureau@redhat.com, pbonzini@redhat.com, philmd@redhat.com,
 mkedzier@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYxNTEyMzcwMC4yNDIy
NTktMS1zdGVmYW5iQGxpbnV4LnZuZXQuaWJtLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWls
ZWQgdGhlIGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0
ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tl
ciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0g
VEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRv
czcgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9X
X0VOVj0xIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgphY3BpLXRlc3Q6
IFdhcm5pbmchIERTRFQgYmluYXJ5IGZpbGUgbWlzbWF0Y2guIEFjdHVhbCBbYW1sOi90bXAvYW1s
LVk3VkpNMF0sIEV4cGVjdGVkIFthbWw6dGVzdHMvZGF0YS9hY3BpL3EzNS9EU0RULnRpc10uClNl
ZSBzb3VyY2UgZmlsZSB0ZXN0cy9xdGVzdC9iaW9zLXRhYmxlcy10ZXN0LmMgZm9yIGluc3RydWN0
aW9ucyBvbiBob3cgdG8gdXBkYXRlIGV4cGVjdGVkIGZpbGVzLgp0byBzZWUgQVNMIGRpZmYgYmV0
d2VlbiBtaXNtYXRjaGVkIGZpbGVzIGluc3RhbGwgSUFTTCwgcmVidWlsZCBRRU1VIGZyb20gc2Ny
YXRjaCBhbmQgcmUtcnVuIHRlc3RzIHdpdGggVj0xIGVudmlyb25tZW50IHZhcmlhYmxlIHNldCoq
CkVSUk9SOi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy9xdGVzdC9iaW9zLXRhYmxlcy10ZXN0LmM6
NDk0OnRlc3RfYWNwaV9hc2w6IGFzc2VydGlvbiBmYWlsZWQ6IChhbGxfdGFibGVzX21hdGNoKQpF
UlJPUiAtIEJhaWwgb3V0ISBFUlJPUjovdG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMvcXRlc3QvYmlv
cy10YWJsZXMtdGVzdC5jOjQ5NDp0ZXN0X2FjcGlfYXNsOiBhc3NlcnRpb24gZmFpbGVkOiAoYWxs
X3RhYmxlc19tYXRjaCkKbWFrZTogKioqIFtjaGVjay1xdGVzdC14ODZfNjRdIEVycm9yIDEKbWFr
ZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBURVNUICAgIGlvdGVzdC1x
Y293MjogMDMwCiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDAzMQotLS0KICAgIHJhaXNlIENhbGxl
ZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9y
OiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2Nv
bS5xZW11Lmluc3RhbmNlLnV1aWQ9NmQ4NTljMDFmZWYwNDg3MTliMDI2YjE2ZDcwZjY1YTgnLCAn
LXUnLCAnMTAwMycsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1y
bScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9Jywg
Jy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5W
PTEnLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0
Y2hldzIvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdics
ICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtMHgyd19fejQvc3JjL2RvY2tlci1zcmMuMjAy
MC0wNi0xNS0wOS4wMC4zNC4zMjAyNDovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpjZW50b3M3
JywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0dXJuZWQgbm9uLXplcm8g
ZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1
aWQ9NmQ4NTljMDFmZWYwNDg3MTliMDI2YjE2ZDcwZjY1YTgKbWFrZVsxXTogKioqIFtkb2NrZXIt
cnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3
LXRlc3Rlci10bXAtMHgyd19fejQvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1xdWlj
a0BjZW50b3M3XSBFcnJvciAyCgpyZWFsICAgIDE0bTUuNTE4cwp1c2VyICAgIDBtOC41MTNzCgoK
VGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIw
MDYxNTEyMzcwMC4yNDIyNTktMS1zdGVmYW5iQGxpbnV4LnZuZXQuaWJtLmNvbS90ZXN0aW5nLmRv
Y2tlci1xdWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0
b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5k
IHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

