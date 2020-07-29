Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88764C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 14:28:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 544E5207E8
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 14:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kkctkZMB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 544E5207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0n4g-0004ZP-Ix
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 10:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <13824125580@163.com>)
 id 1k0n45-00046H-9s
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 10:28:17 -0400
Received: from m13153.mail.163.com ([220.181.13.153]:5779)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <13824125580@163.com>)
 id 1k0n3y-0001i3-RU
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 10:28:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=bqSax
 H6uUBBEmFTQCKVLX6KCpwrCs1CKfHR7/JJgWbA=; b=kkctkZMBZOJlLUvF5yU/e
 m5pCpYPRneYNZDxZlpNR3qsMft6H+qqJueVj10wToZ7hvN7qWsR58sdz+jIyjJds
 Aw8ZwxHm2HSwu85iBqD8XpXfwkUEs+fFCl+qr+iYgS7ykUBVf+tpbj5B/nnAbUCK
 zXNJdZ2AwpO1QC0D7R8AkM=
Received: from 13824125580$163.com ( [113.74.44.15] ) by
 ajax-webmail-wmsvr153 (Coremail) ; Wed, 29 Jul 2020 22:27:55 +0800 (CST)
X-Originating-IP: [113.74.44.15]
Date: Wed, 29 Jul 2020 22:27:55 +0800 (CST)
From: tugouxp <13824125580@163.com>
To: qemu-devel@nongnu.org
Subject: What this mean "dead: 1" and "dead: 0 1" on each tb block start?
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190724(ac680a23)
 Copyright (c) 2002-2020 www.mailtech.cn 163com
X-CM-CTRLDATA: Do1L9mZvb3Rlcl9odG09Mjg4Njo2MQ==
Content-Type: multipart/alternative; 
 boundary="----=_Part_114287_606518536.1596032875538"
MIME-Version: 1.0
Message-ID: <6807386b.7ba3.1739af8fc12.Coremail.13824125580@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: mcGowADX5JlrhyFfYaNdAA--.22847W
X-CM-SenderInfo: bprtmjyurskkiyq6il2tof0z/1tbiVh9wQlqzmHTMLwACsf
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Received-SPF: pass client-ip=220.181.13.153; envelope-from=13824125580@163.com;
 helo=m13153.mail.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 10:27:55
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FROM_LOCAL_DIGITS=0.001,
 FROM_LOCAL_HEX=0.006, HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

------=_Part_114287_606518536.1596032875538
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

SEkgZm9sa3M6CiAgb24gZWFjaCB0YiBibG9jayBzdGFydCwgdGhlcmUgYXJlIGZvbGxvd2luZyBp
ciBjb2RlLCBhbmQgdGhlIG1vc3QgY29uZnVzaW5nIG1lIGlzIHRoYXQgIHRoZSBwb3N0Zml4IG9m
IGVhY2ggbGluZSAiZGVhZDoiIGZsYWcsIHdoYXQgaXQgaXMgcmVwcmVzZW50IHByZWNpc2VseT8K
aSBndWVzcyBpdCBtYXkgYmUgcmVsYXRlZCB0byB0aGUgcmVnaXN0ZXIgb3IgdmFyaWJsZSBsaXZl
bmVzcyBmb3IgaGVscCBnZW5lcmF0aW5nIHRnaGUgdGFyZ2V0IG1hY2hpbmUgY29kZSwgYnV0IGkg
Y2FudCBnZXQgdGhlIHByZWNpc2VseSBjb25uZWN0aW9uIG9mIHRoZSBkZWFkIGF0dHJyaWJ1dGUg
d2l0aCBxZW11ICBpbnRlcm5hbCB2YXJpYmxlcy4KZm9yIGV4YW1wbGUsIHdoeSB0aGUgbGluZSA2
MSB1c2UgImRlYWQ6MSIgYW5kIHRoZSBsaW5lIDYzIHVzZSAiZGVhZDogMCwgMSI/ICB3aGF0IGlz
IHRoZSBwcmVjaXNlbHkgbWVhbmluZyBvZiB0aGUgbnVtYmVyIGFmdGVyIHRoZSAiZGVhZDoiIHdv
cmQ/CgoKdGhhbmsgeW91ISAgICAgCgoKCgogICAgNjAgT1AgYWZ0ZXIgb3B0aW1pemF0aW9uIGFu
ZCBsaXZlbmVzcyBhbmFseXNpczoKCiAgICAgNjEgIGxkX2kzMiB0bXA1LGVudiwkMHhmZmZmZmZm
ZmZmZmZmZmVjICAgICAgICAgICAgICAgICBkZWFkOiAxCgogICAgIDYyICBtb3ZpX2kzMiB0bXA2
LCQweDAKCiAgICAgNjMgIGJyY29uZF9pMzIgdG1wNSx0bXA2LGx0LCRMMCAgICAgICAgICAgICAg
ICAgICAgICBkZWFkOiAwIDEKCiAgICAgNjQgIAoKICAgICA2NSAgLS0tLSA2MDAwMDAwNCAwMDAw
MDAwMCAwMDAwMGUwNAoKICAgICA2NiAgbW92aV9pMzIgdG1wNSwkMHg2MDAwMDAxMAoKICAgICA2
NyAgbW92X2kzMiB0bXA3LHRtcDUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRlYWQ6
IDEKCiAgICAgNjggIHFlbXVfbGRfaTMyIHRtcDYsdG1wNyxsZXVsLDMgICAgICAgICAgICAgICAg
ICAgICBkZWFkOiAxCgogICAgIDY5ICBtb3ZfaTMyIHIxLHRtcDYgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgc3luYzogMCAgZGVhZDogMCAxCgogICAgIDcwICBnb3RvX3RiICQweDEK
CiAgICAgNzEgIG1vdmlfaTMyIHBjLCQweDYwMDAwMDA4ICAgICAgICAgICAgICAgICAgICAgICAg
ICBzeW5jOiAwICBkZWFkOiAwCgogICAgIDcyICBleGl0X3RiICQweDdmOGU4ZWY1ODEwMQoKICAg
ICA3MyAgc2V0X2xhYmVsICRMMAoKICAgICA3NCAgZXhpdF90YiAkMHg3ZjhlOGVmNTgxMDMKCiAg
ICAgNzUgIAoKCg==
------=_Part_114287_606518536.1596032875538
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS43O2NvbG9yOiMwMDAwMDA7Zm9udC1zaXplOjE0cHg7
Zm9udC1mYW1pbHk6QXJpYWwiPjxkaXYgc3R5bGU9Im1hcmdpbjowOyI+SEkgZm9sa3M6PC9kaXY+
PGRpdiBzdHlsZT0ibWFyZ2luOjA7Ij4mbmJzcDsgb24gZWFjaCB0YiBibG9jayBzdGFydCwgdGhl
cmUgYXJlIGZvbGxvd2luZyBpciBjb2RlLCBhbmQgdGhlIG1vc3QgY29uZnVzaW5nIG1lIGlzIHRo
YXQmbmJzcDsgdGhlIHBvc3RmaXggb2YgZWFjaCBsaW5lICJkZWFkOiIgZmxhZywgd2hhdCBpdCBp
cyByZXByZXNlbnQgcHJlY2lzZWx5PzwvZGl2PjxkaXYgc3R5bGU9Im1hcmdpbjowOyI+aSBndWVz
cyBpdCBtYXkgYmUgcmVsYXRlZCB0byB0aGUgcmVnaXN0ZXIgb3IgdmFyaWJsZSBsaXZlbmVzcyBm
b3IgaGVscCBnZW5lcmF0aW5nIHRnaGUgdGFyZ2V0IG1hY2hpbmUgY29kZSwgYnV0IGkgY2FudCBn
ZXQgdGhlIHByZWNpc2VseSBjb25uZWN0aW9uIG9mIHRoZSBkZWFkIGF0dHJyaWJ1dGUgd2l0aCBx
ZW11Jm5ic3A7IGludGVybmFsIHZhcmlibGVzLjwvZGl2PjxkaXYgc3R5bGU9Im1hcmdpbjowOyI+
Zm9yIGV4YW1wbGUsIHdoeSB0aGUgbGluZSA2MSB1c2UgImRlYWQ6MSIgYW5kIHRoZSBsaW5lIDYz
IHVzZSAiZGVhZDogMCwgMSI/Jm5ic3A7IHdoYXQgaXMgdGhlIHByZWNpc2VseSBtZWFuaW5nIG9m
IHRoZSBudW1iZXIgYWZ0ZXIgdGhlICJkZWFkOiIgd29yZD88L2Rpdj48ZGl2IHN0eWxlPSJtYXJn
aW46MDsiPjxicj48L2Rpdj48ZGl2IHN0eWxlPSJtYXJnaW46MDsiPnRoYW5rIHlvdSEmbmJzcDsg
Jm5ic3A7ICZuYnNwOzwvZGl2PjxkaXYgc3R5bGU9Im1hcmdpbjowOyI+PGJyPjwvZGl2PjxkaXYg
c3R5bGU9Im1hcmdpbjowOyI+PGJyPjwvZGl2PjxkaXYgc3R5bGU9Im1hcmdpbjowOyI+Jm5ic3A7
ICZuYnNwOyA2MCBPUCBhZnRlciBvcHRpbWl6YXRpb24gYW5kIGxpdmVuZXNzIGFuYWx5c2lzOjwv
ZGl2PjxwIHN0eWxlPSJtYXJnaW46MDsiPjxzcGFuIHN0eWxlPSJiYWNrZ3JvdW5kLWNvbG9yOiBy
Z2IoMjIxLCA2NCwgNTApOyI+Jm5ic3A7ICZuYnNwOyAmbmJzcDs2MSZuYnNwOyBsZF9pMzIgdG1w
NSxlbnYsJDB4ZmZmZmZmZmZmZmZmZmZlYyZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJz
cDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ZGVhZDogMTwvc3Bhbj48L3A+PHAgc3R5bGU9
Im1hcmdpbjowOyI+PHNwYW4gc3R5bGU9ImJhY2tncm91bmQtY29sb3I6IHJnYigyMjEsIDY0LCA1
MCk7Ij4mbmJzcDsgJm5ic3A7ICZuYnNwOzYyJm5ic3A7IG1vdmlfaTMyIHRtcDYsJDB4MDwvc3Bh
bj48L3A+PHAgc3R5bGU9Im1hcmdpbjowOyI+PHNwYW4gc3R5bGU9ImJhY2tncm91bmQtY29sb3I6
IHJnYigyMjEsIDY0LCA1MCk7Ij4mbmJzcDsgJm5ic3A7ICZuYnNwOzYzJm5ic3A7IGJyY29uZF9p
MzIgdG1wNSx0bXA2LGx0LCRMMCZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5i
c3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgZGVhZDogMCAxPC9zcGFuPjwv
cD48cCBzdHlsZT0ibWFyZ2luOjA7Ij4mbmJzcDsgJm5ic3A7ICZuYnNwOzY0Jm5ic3A7Jm5ic3A7
PC9wPjxwIHN0eWxlPSJtYXJnaW46MDsiPiZuYnNwOyAmbmJzcDsgJm5ic3A7NjUmbmJzcDsgLS0t
LSA2MDAwMDAwNCAwMDAwMDAwMCAwMDAwMGUwNDwvcD48cCBzdHlsZT0ibWFyZ2luOjA7Ij4mbmJz
cDsgJm5ic3A7ICZuYnNwOzY2Jm5ic3A7IG1vdmlfaTMyIHRtcDUsJDB4NjAwMDAwMTA8L3A+PHAg
c3R5bGU9Im1hcmdpbjowOyI+Jm5ic3A7ICZuYnNwOyAmbmJzcDs2NyZuYnNwOyBtb3ZfaTMyIHRt
cDcsdG1wNSZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAm
bmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZu
YnNwOyBkZWFkOiAxPC9wPjxwIHN0eWxlPSJtYXJnaW46MDsiPiZuYnNwOyAmbmJzcDsgJm5ic3A7
NjgmbmJzcDsgcWVtdV9sZF9pMzIgdG1wNix0bXA3LGxldWwsMyZuYnNwOyAmbmJzcDsgJm5ic3A7
ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDtk
ZWFkOiAxPC9wPjxwIHN0eWxlPSJtYXJnaW46MDsiPiZuYnNwOyAmbmJzcDsgJm5ic3A7NjkmbmJz
cDsgbW92X2kzMiByMSx0bXA2Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJz
cDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNw
OyAmbmJzcDsgJm5ic3A7ICZuYnNwOyBzeW5jOiAwJm5ic3A7IGRlYWQ6IDAgMTwvcD48cCBzdHls
ZT0ibWFyZ2luOjA7Ij4mbmJzcDsgJm5ic3A7ICZuYnNwOzcwJm5ic3A7IGdvdG9fdGIgJDB4MTwv
cD48cCBzdHlsZT0ibWFyZ2luOjA7Ij4mbmJzcDsgJm5ic3A7ICZuYnNwOzcxJm5ic3A7IG1vdmlf
aTMyIHBjLCQweDYwMDAwMDA4Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJz
cDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7IHN5bmM6
IDAmbmJzcDsgZGVhZDogMDwvcD48cCBzdHlsZT0ibWFyZ2luOjA7Ij4mbmJzcDsgJm5ic3A7ICZu
YnNwOzcyJm5ic3A7IGV4aXRfdGIgJDB4N2Y4ZThlZjU4MTAxPC9wPjxwIHN0eWxlPSJtYXJnaW46
MDsiPiZuYnNwOyAmbmJzcDsgJm5ic3A7NzMmbmJzcDsgc2V0X2xhYmVsICRMMDwvcD48cCBzdHls
ZT0ibWFyZ2luOjA7Ij4mbmJzcDsgJm5ic3A7ICZuYnNwOzc0Jm5ic3A7IGV4aXRfdGIgJDB4N2Y4
ZThlZjU4MTAzPC9wPjxwIHN0eWxlPSJtYXJnaW46MDsiPiZuYnNwOyAmbmJzcDsgJm5ic3A7NzUm
bmJzcDsmbmJzcDs8L3A+PGRpdj48YnI+PC9kaXY+PC9kaXY+PGJyPjxicj48c3BhbiB0aXRsZT0i
bmV0ZWFzZWZvb3RlciI+PHA+PGJyLz4mbmJzcDs8L3A+PC9zcGFuPg==
------=_Part_114287_606518536.1596032875538--


