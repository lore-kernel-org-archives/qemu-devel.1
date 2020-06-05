Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1719C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 21:45:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5A4A206A2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 21:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5A4A206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhK9h-00084E-0a
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 17:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jhK92-0007ep-Pk
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 17:44:56 -0400
Resent-Date: Fri, 05 Jun 2020 17:44:56 -0400
Resent-Message-Id: <E1jhK92-0007ep-Pk@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21332)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jhK90-0001v9-TG
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 17:44:56 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591393485; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fdtEV6hiGmlKmGd7PiA7pvlVwAg1UYv3lOUy/A0I0QbndT93fldHBhpZiyph2yHjC4uemuScUULR0H/e8TF7sTOWoYBIHxIoFl0ju7L2oLm9oxmsNSBEGYHMtcYbvUYP8ljI9ccCOPRpnlANe/a1JOYa8Iz/9J4/FJFZcVnlaXg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1591393485;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=eFG9mVkE/LJ8BXBc+YwLZEacPGnY43BWj8qM/PhxfOk=; 
 b=TGd+2O+xtVd1woZ3hEkhYhYc5hshSeK66RnelvsPEZBY7Ymf87hBlYOT4Bfmv2uPuTo5ZyrnIx31RhfzxBCEMOtFFEMi07bkbVpnP62h4kCH0We6kLUec0cay6MbniMX2opwKrCDYzylOogUZwwwzGOl0QHGaxLFTs0hWZWjXc0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 159139348286199.64783782277902;
 Fri, 5 Jun 2020 14:44:42 -0700 (PDT)
Message-ID: <159139348156.19958.10355739158702476362@45ef0f9c86ae>
In-Reply-To: <20200605173422.1490-1-robert.foley@linaro.org>
Subject: Re: [PATCH v2 00/13] Add Thread Sanitizer support to QEMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: robert.foley@linaro.org
Date: Fri, 5 Jun 2020 14:44:42 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 15:51:05
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.puhov@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, robert.foley@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYwNTE3MzQyMi4xNDkw
LTEtcm9iZXJ0LmZvbGV5QGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRo
ZSBhc2FuIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0
aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4g
cHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09
CiMhL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRvY2tlci1pbWFnZS1mZWRvcmEg
Vj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtZGVidWdAZmVkb3JhIFRBUkdFVF9M
SVNUPXg4Nl82NC1zb2Z0bW11IEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09
CgpQQVNTIDEgZmRjLXRlc3QgL3g4Nl82NC9mZGMvY21vcwpQQVNTIDIgZmRjLXRlc3QgL3g4Nl82
NC9mZGMvbm9fbWVkaWFfb25fc3RhcnQKUEFTUyAzIGZkYy10ZXN0IC94ODZfNjQvZmRjL3JlYWRf
d2l0aG91dF9tZWRpYQo9PTkxNjA9PVdBUk5JTkc6IEFTYW4gZG9lc24ndCBmdWxseSBzdXBwb3J0
IG1ha2Vjb250ZXh0L3N3YXBjb250ZXh0IGZ1bmN0aW9ucyBhbmQgbWF5IHByb2R1Y2UgZmFsc2Ug
cG9zaXRpdmVzIGluIHNvbWUgY2FzZXMhCj09OTE2MD09RVJST1I6IGZpbmlzaGluZyBhIGZpYmVy
IHN3aXRjaCB0aGF0IGhhcyBub3Qgc3RhcnRlZApQQVNTIDggdGVzdC1zdHJpbmctaW5wdXQtdmlz
aXRvciAvc3RyaW5nLXZpc2l0b3IvaW5wdXQvZnV6egpCcm9rZW4gcGlwZQovdG1wL3FlbXUtdGVz
dC9zcmMvdGVzdHMvcXRlc3QvbGlicXRlc3QuYzoxNjY6IGtpbGxfcWVtdSgpIHRyaWVkIHRvIHRl
cm1pbmF0ZSBRRU1VIHByb2Nlc3MgYnV0IGVuY291bnRlcmVkIGV4aXQgc3RhdHVzIDEgKGV4cGVj
dGVkIDApCkVSUk9SIC0gdG9vIGZldyB0ZXN0cyBydW4gKGV4cGVjdGVkIDEzLCBnb3QgMykKTUFM
TE9DX1BFUlRVUkJfPSR7TUFMTE9DX1BFUlRVUkJfOi0kKCggJHtSQU5ET006LTB9ICUgMjU1ICsg
MSkpfSAgdGVzdHMvdGVzdC1zdHJpbmctb3V0cHV0LXZpc2l0b3IgLW09cXVpY2sgLWsgLS10YXAg
PCAvZGV2L251bGwgfCAuL3NjcmlwdHMvdGFwLWRyaXZlci5wbCAtLXRlc3QtbmFtZT0idGVzdC1z
dHJpbmctb3V0cHV0LXZpc2l0b3IiIAptYWtlOiAqKiogWy90bXAvcWVtdS10ZXN0L3NyYy90ZXN0
cy9NYWtlZmlsZS5pbmNsdWRlOjY0MjogY2hlY2stcXRlc3QteDg2XzY0XSBFcnJvciAxCm1ha2U6
ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uClBBU1MgMSB0ZXN0LXN0cmluZy1v
dXRwdXQtdmlzaXRvciAvc3RyaW5nLXZpc2l0b3Ivb3V0cHV0L2ludApQQVNTIDIgdGVzdC1zdHJp
bmctb3V0cHV0LXZpc2l0b3IgL3N0cmluZy12aXNpdG9yL291dHB1dC9pbnQtaHVtYW4KLS0tClBB
U1MgMzIgdGVzdC1vcHRzLXZpc2l0b3IgL3Zpc2l0b3Ivb3B0cy9yYW5nZS9iZXlvbmQKUEFTUyAz
MyB0ZXN0LW9wdHMtdmlzaXRvciAvdmlzaXRvci9vcHRzL2RpY3QvdW52aXNpdGVkCk1BTExPQ19Q
RVJUVVJCXz0ke01BTExPQ19QRVJUVVJCXzotJCgoICR7UkFORE9NOi0wfSAlIDI1NSArIDEpKX0g
IHRlc3RzL3Rlc3QtY29yb3V0aW5lIC1tPXF1aWNrIC1rIC0tdGFwIDwgL2Rldi9udWxsIHwgLi9z
Y3JpcHRzL3RhcC1kcml2ZXIucGwgLS10ZXN0LW5hbWU9InRlc3QtY29yb3V0aW5lIiAKPT05MTkw
PT1XQVJOSU5HOiBBU2FuIGRvZXNuJ3QgZnVsbHkgc3VwcG9ydCBtYWtlY29udGV4dC9zd2FwY29u
dGV4dCBmdW5jdGlvbnMgYW5kIG1heSBwcm9kdWNlIGZhbHNlIHBvc2l0aXZlcyBpbiBzb21lIGNh
c2VzIQo9PTkxOTA9PUVSUk9SOiBmaW5pc2hpbmcgYSBmaWJlciBzd2l0Y2ggdGhhdCBoYXMgbm90
IHN0YXJ0ZWQKRVJST1IgLSB0b28gZmV3IHRlc3RzIHJ1biAoZXhwZWN0ZWQgMTAsIGdvdCAwKQpt
YWtlOiAqKiogWy90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy9NYWtlZmlsZS5pbmNsdWRlOjY0Nzog
Y2hlY2stdW5pdF0gRXJyb3IgMQpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAg
RmlsZSAiLi90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2NjUsIGluIDxtb2R1bGU+CiAg
ICBzeXMuZXhpdChtYWluKCkpCi0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNv
ZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3Vkbycs
ICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVp
ZD00MWMyOTc3NmNkMmM0MGJmOGQ0M2U5OGYzMDAxNzcyZCcsICctdScsICcxMDAzJywgJy0tc2Vj
dXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9M
SVNUPXg4Nl82NC1zb2Z0bW11JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScs
ICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0nLCAn
LWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldzIv
LmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFy
L3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtczBvazRpX3ovc3JjL2RvY2tlci1zcmMuMjAyMC0wNi0w
NS0xNy4xNS40Ni4yMDIyOi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmZlZG9yYScsICcvdmFy
L3RtcC9xZW11L3J1bicsICd0ZXN0LWRlYnVnJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3Rh
dHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTQxYzI5
Nzc2Y2QyYzQwYmY4ZDQzZTk4ZjMwMDE3NzJkCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJy
b3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXIt
dG1wLXMwb2s0aV96L3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtZGVidWdAZmVkb3Jh
XSBFcnJvciAyCgpyZWFsICAgIDI4bTU0LjExOHMKdXNlciAgICAwbTguNzM2cwoKClRoZSBmdWxs
IGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA2MDUxNzM0
MjIuMTQ5MC0xLXJvYmVydC5mb2xleUBsaW5hcm8ub3JnL3Rlc3RpbmcuYXNhbi8/dHlwZT1tZXNz
YWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6
Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2
ZWxAcmVkaGF0LmNvbQ==

