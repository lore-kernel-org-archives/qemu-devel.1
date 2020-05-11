Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267F4C54E4A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 14:09:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9A04206DB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 14:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Gu5hGOn0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A04206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY97a-0005Gj-56
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 10:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <13824125580@163.com>)
 id 1jY96H-0003z4-Ua
 for qemu-devel@nongnu.org; Mon, 11 May 2020 10:08:10 -0400
Received: from m13-81.163.com ([220.181.13.81]:31099)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <13824125580@163.com>)
 id 1jY96D-0002dF-13
 for qemu-devel@nongnu.org; Mon, 11 May 2020 10:08:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=kVT6v
 zZ3iGi/ns83U1Vk9CE/+JMUIYPpaJaMsLb3RPg=; b=Gu5hGOn0ALyMigvk1U4SV
 W/zAu2fFBox2y6xigMxFx46nfsqS8cKCT+X2adCvffxPGDbTm2Yah8H9OjMaC3Zh
 bcPpw3ZKB2HuiG5KyV3RiGaCNRgV78kbPtTJw9hvdlNMh86JiEQV+28vqWzpJxuP
 2EHGYoekKTz7SARxLN7zb8=
Received: from 13824125580$163.com ( [113.74.45.41] ) by
 ajax-webmail-wmsvr81 (Coremail) ; Mon, 11 May 2020 22:07:34 +0800 (CST)
X-Originating-IP: [113.74.45.41]
Date: Mon, 11 May 2020 22:07:34 +0800 (CST)
From: tugouxp <13824125580@163.com>
To: qemu-devel@nongnu.org
Subject: Is qemu could be a "FSM" state machine if running on a "quiet and
 clean" host pc without random event input?
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190724(ac680a23)
 Copyright (c) 2002-2020 www.mailtech.cn 163com
X-CM-CTRLDATA: nJAJWGZvb3Rlcl9odG09MTIyNTo2MQ==
Content-Type: multipart/alternative; 
 boundary="----=_Part_124533_722150239.1589206054153"
MIME-Version: 1.0
Message-ID: <7da014ca.86ed.172040ff509.Coremail.13824125580@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: UcGowAC31rYnXLle_H4sAA--.30090W
X-CM-SenderInfo: bprtmjyurskkiyq6il2tof0z/xtbBRQchQlPAFsHn5QAAsn
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Received-SPF: pass client-ip=220.181.13.81; envelope-from=13824125580@163.com;
 helo=m13-81.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 10:07:36
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FROM_LOCAL_DIGITS=0.001,
 FROM_LOCAL_HEX=0.006, HTML_MESSAGE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

------=_Part_124533_722150239.1589206054153
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

SGkgZm9sa3M6CiAgaSB3YW50IHRvIGtub3cgYWJvdXQgd2hldGhlciB0aGVyciBhcmUgbGltaXRh
dGlvbnMgZHVyaW5nIHFlbXUgZW11bGF0aW9uIHN5c3RlbXMsIGZvciBleGFtcGUsIGRpZCB0aGUg
cmVndWxhciBidWdzIGNvcmVuZXIgY2FzZSBjYW50IGJlIGR1cGxpY2F0ZWQgb24gcWVtZSBidXQg
ZXhpc3Qgb24gcmVhbCBib2Fkcz8KCgp3aHkgdGhpbmcgdGhpcyBpcyB0aGF0ICwgaSBoYXZlIGV2
ZXIgdXNlIGhkbCBzaW11bGF0b3IgKG1vZHNpbSBhbmQgaXZlcmlsb2cpIGFuZCBvcGVucmlzYyBw
cm9jZXNzb3IgdG8gZW11bGF0ZSB0aGUgbGludXggYW5kIHVjb3MgcnVubmluZywgYW5kIHNlZSB0
aGUgd2F2ZWZvcm0gb2YgdGhlIHNpbXVsYXRlaW9uIHByb2Nlc3Mgb2YgdGhlIG9wZXJhdGlvbnMg
c3lzdGVtcy4KaSBmb3VuZCBhbiBpbnRlcmVzdGluZyB0aGluZ3MsIGlmIGkgdGFrZSBqdXN0IHRo
ZSB0aWNrIGludGVycnVwdCBhcyB0aGUgb25seSB0ZXN0YmVjaCBldmVudCBzb3VyY2UsdGhlICBr
ZXJuZWwgc2ltdWxhdGlvbiB3YXZlZm9ybSBpcyBpZGVudGljYWwgZHVwbGljYXRlZCBhZ2FpbiBh
bmQgYWdhaW4sIHdoaWNoIG1lYW5zIGkgY2FuIHByZWRpY2F0ZSBmdXR1cmUgYmVoYXZpb3IuCgoK
aSB0aGluayB0aGlzIHNvbWV0aGluZyBsaWtlIHFlbXUgd29yayBwcmluY2lwbGUgYW5kIHNvIHdh
bnQgdG8ga25vdywgd2hldGhlciB0aGUgcWVtdSBoYXMgdGhpcyBsaW1pdGF0aW9uPyBpcyB0aGUg
c2ltdWxhdGlvbiBwcm9jZXMgYSAiRlNNIiAgdGhhdCB3aXRoIGRlZmluaXRpb24gb3V0cHV0IGlm
IHRoZSBpbnB1dCBldmVudCBhcmUgYWxsIHJlZ3VsYXIgYW5kIHdpdGhvdXQgcmFuZG9tPwoKCnRo
YW5rIHlvdQo=
------=_Part_124533_722150239.1589206054153
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS43O2NvbG9yOiMwMDAwMDA7Zm9udC1zaXplOjE0cHg7
Zm9udC1mYW1pbHk6QXJpYWwiPjxkaXYgc3R5bGU9Im1hcmdpbjowOyI+SGkgZm9sa3M6PC9kaXY+
PGRpdiBzdHlsZT0ibWFyZ2luOjA7Ij4mbmJzcDsgaSB3YW50IHRvIGtub3cgYWJvdXQgd2hldGhl
ciB0aGVyciBhcmUgbGltaXRhdGlvbnMgZHVyaW5nIHFlbXUgZW11bGF0aW9uIHN5c3RlbXMsIGZv
ciBleGFtcGUsIGRpZCB0aGUgcmVndWxhciBidWdzIGNvcmVuZXIgY2FzZSBjYW50IGJlIGR1cGxp
Y2F0ZWQgb24gcWVtZSBidXQgZXhpc3Qgb24gcmVhbCBib2Fkcz88L2Rpdj48ZGl2IHN0eWxlPSJt
YXJnaW46MDsiPjxicj48L2Rpdj48ZGl2IHN0eWxlPSJtYXJnaW46MDsiPndoeSB0aGluZyB0aGlz
IGlzIHRoYXQgLCBpIGhhdmUgZXZlciB1c2UgaGRsIHNpbXVsYXRvciAobW9kc2ltIGFuZCBpdmVy
aWxvZykgYW5kIG9wZW5yaXNjIHByb2Nlc3NvciB0byBlbXVsYXRlIHRoZSBsaW51eCBhbmQgdWNv
cyBydW5uaW5nLCBhbmQgc2VlIHRoZSB3YXZlZm9ybSBvZiB0aGUgc2ltdWxhdGVpb24gcHJvY2Vz
cyBvZiB0aGUgb3BlcmF0aW9ucyBzeXN0ZW1zLjwvZGl2PjxkaXYgc3R5bGU9Im1hcmdpbjowOyI+
aSBmb3VuZCBhbiBpbnRlcmVzdGluZyB0aGluZ3MsIGlmIGkgdGFrZSBqdXN0IHRoZSB0aWNrIGlu
dGVycnVwdCBhcyB0aGUgb25seSB0ZXN0YmVjaCBldmVudCBzb3VyY2UsdGhlJm5ic3A7IGtlcm5l
bCBzaW11bGF0aW9uIHdhdmVmb3JtIGlzIGlkZW50aWNhbCBkdXBsaWNhdGVkIGFnYWluIGFuZCBh
Z2Fpbiwgd2hpY2ggbWVhbnMgaSBjYW4gcHJlZGljYXRlIGZ1dHVyZSBiZWhhdmlvci48L2Rpdj48
ZGl2IHN0eWxlPSJtYXJnaW46MDsiPjxicj48L2Rpdj48ZGl2IHN0eWxlPSJtYXJnaW46MDsiPmkg
dGhpbmsgdGhpcyBzb21ldGhpbmcgbGlrZSBxZW11IHdvcmsgcHJpbmNpcGxlIGFuZCBzbyB3YW50
IHRvIGtub3csIHdoZXRoZXIgdGhlIHFlbXUgaGFzIHRoaXMgbGltaXRhdGlvbj8gaXMgdGhlIHNp
bXVsYXRpb24gcHJvY2VzIGEgIkZTTSImbmJzcDsgdGhhdCB3aXRoIGRlZmluaXRpb24gb3V0cHV0
IGlmIHRoZSBpbnB1dCBldmVudCBhcmUgYWxsIHJlZ3VsYXIgYW5kIHdpdGhvdXQgcmFuZG9tPzwv
ZGl2PjxkaXYgc3R5bGU9Im1hcmdpbjowOyI+PGJyPjwvZGl2PjxkaXYgc3R5bGU9Im1hcmdpbjow
OyI+dGhhbmsgeW91PGJyPjwvZGl2PjwvZGl2Pjxicj48YnI+PHNwYW4gdGl0bGU9Im5ldGVhc2Vm
b290ZXIiPjxwPjxici8+Jm5ic3A7PC9wPjwvc3Bhbj4=
------=_Part_124533_722150239.1589206054153--


