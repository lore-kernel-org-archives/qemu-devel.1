Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9DDC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 00:58:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 460C92054F
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 00:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="o1Hn7UlB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 460C92054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ2CG-00072G-2v
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 20:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <13824125580@163.com>)
 id 1jZ2BF-00061u-G6
 for qemu-devel@nongnu.org; Wed, 13 May 2020 20:56:57 -0400
Received: from m13-56.163.com ([220.181.13.56]:36588)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <13824125580@163.com>)
 id 1jZ2BB-0007sv-Cx
 for qemu-devel@nongnu.org; Wed, 13 May 2020 20:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=nhGzr
 rSM3GoD5fk389xWIqg3TeHFEvuOvjcMiNWcupY=; b=o1Hn7UlBVRkMGxObi79XS
 N4Vxhg3qYMeE9lK3u2pzNZeyhpzO5nrG7aK/ru5hIc6hdcPOQIbI/Maw/PwKP8fG
 fvzb2LsQnXKMpBNclyO7u8mEF8TYnq3syunLLh9VCpU+hyI93EV03fH5r2oNRvdh
 mqVRZ7ILxf8SztU44bNZuU=
Received: from 13824125580$163.com ( [221.4.213.95] ) by
 ajax-webmail-wmsvr56 (Coremail) ; Thu, 14 May 2020 08:56:45 +0800 (CST)
X-Originating-IP: [221.4.213.95]
Date: Thu, 14 May 2020 08:56:45 +0800 (CST)
From: tugouxp  <13824125580@163.com>
To: "John Snow" <jsnow@redhat.com>
Subject: Re:Re: Is qemu could be a "FSM" state machine if running on a
 "quiet and clean" host pc without random event input?
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190724(ac680a23)
 Copyright (c) 2002-2020 www.mailtech.cn 163com
In-Reply-To: <314a82f2-6ceb-e5ee-c3c6-6d2c2c4730e4@redhat.com>
References: <7da014ca.86ed.172040ff509.Coremail.13824125580@163.com>
 <314a82f2-6ceb-e5ee-c3c6-6d2c2c4730e4@redhat.com>
X-CM-CTRLDATA: vFFA3mZvb3Rlcl9odG09MjQwMjo2MQ==
Content-Type: multipart/alternative; 
 boundary="----=_Part_12226_1848168320.1589417805164"
MIME-Version: 1.0
Message-ID: <5facd066.d8c.17210af056d.Coremail.13824125580@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: OMGowABnfWBNl7xeRuktAA--.22292W
X-CM-SenderInfo: bprtmjyurskkiyq6il2tof0z/1tbipQsjQlUMYBqicQABs+
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Received-SPF: pass client-ip=220.181.13.56; envelope-from=13824125580@163.com;
 helo=m13-56.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 20:56:47
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

------=_Part_12226_1848168320.1589417805164
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

VGhhbmsgeW91LCBtdWNoIGFwcHJlY2lhdGUgeW91ciB0aG91Z2h0IGFuZCBtZWFuaW5nZnVsIGZv
ciBtZSEKCgoKCgoKCgoKCgoKCgoKCgpBdCAyMDIwLTA1LTE0IDA3OjIyOjEyLCAiSm9obiBTbm93
IiA8anNub3dAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPgo+T24gNS8xMS8yMCAxMDowNyBBTSwgdHVn
b3V4cCB3cm90ZToKPj4gSGkgZm9sa3M6Cj4+ICAgaSB3YW50IHRvIGtub3cgYWJvdXQgd2hldGhl
ciB0aGVyciBhcmUgbGltaXRhdGlvbnMgZHVyaW5nIHFlbXUKPj4gZW11bGF0aW9uIHN5c3RlbXMs
IGZvciBleGFtcGUsIGRpZCB0aGUgcmVndWxhciBidWdzIGNvcmVuZXIgY2FzZSBjYW50IGJlCj4+
IGR1cGxpY2F0ZWQgb24gcWVtZSBidXQgZXhpc3Qgb24gcmVhbCBib2Fkcz8KPj4gCj4KPkl0J3Mg
cG9zc2libGUsIHllcy4gUUVNVSBlbXVsYXRlcyBpbnN0ZWFkIG9mIHNpbXVsYXRlcy4gV2UgZG8g
bm90IHRyeSB0bwo+cmVwcm9kdWNlIGFjY3VyYXRlIGN5Y2xlIHRpbWluZ3MuIFRoZXJlIG1heSBi
ZSBidWdzIHRoYXQgZXhpc3QgaW4gcmVhbAo+aGFyZHdhcmUgYnV0IGRvbid0IHJlcHJvZHVjZSB3
aXRoIFFFTVUsIG9yLCBvZiBjb3Vyc2UsIHRoZSBvdGhlciB3YXkgYXJvdW5kLgo+Cj4+IHdoeSB0
aGluZyB0aGlzIGlzIHRoYXQgLCBpIGhhdmUgZXZlciB1c2UgaGRsIHNpbXVsYXRvciAobW9kc2lt
IGFuZAo+PiBpdmVyaWxvZykgYW5kIG9wZW5yaXNjIHByb2Nlc3NvciB0byBlbXVsYXRlIHRoZSBs
aW51eCBhbmQgdWNvcyBydW5uaW5nLAo+PiBhbmQgc2VlIHRoZSB3YXZlZm9ybSBvZiB0aGUgc2lt
dWxhdGVpb24gcHJvY2VzcyBvZiB0aGUgb3BlcmF0aW9ucyBzeXN0ZW1zLgo+PiBpIGZvdW5kIGFu
IGludGVyZXN0aW5nIHRoaW5ncywgaWYgaSB0YWtlIGp1c3QgdGhlIHRpY2sgaW50ZXJydXB0IGFz
IHRoZQo+PiBvbmx5IHRlc3RiZWNoIGV2ZW50IHNvdXJjZSx0aGUgIGtlcm5lbCBzaW11bGF0aW9u
IHdhdmVmb3JtIGlzIGlkZW50aWNhbAo+PiBkdXBsaWNhdGVkIGFnYWluIGFuZCBhZ2Fpbiwgd2hp
Y2ggbWVhbnMgaSBjYW4gcHJlZGljYXRlIGZ1dHVyZSBiZWhhdmlvci4KPj4gCj4KPlllYWgsIHdl
IGFyZSBub3Qgb3BlcmF0aW5nIG9uIHRoZSB2ZXJpbG9nIGxldmVsIGZvciBhbnkgb2YgdGhlIGhh
cmR3YXJlCj53ZSBlbXVsYXRlLgo+Cj4+IGkgdGhpbmsgdGhpcyBzb21ldGhpbmcgbGlrZSBxZW11
IHdvcmsgcHJpbmNpcGxlIGFuZCBzbyB3YW50IHRvIGtub3csCj4+IHdoZXRoZXIgdGhlIHFlbXUg
aGFzIHRoaXMgbGltaXRhdGlvbj8gaXMgdGhlIHNpbXVsYXRpb24gcHJvY2VzIGEgIkZTTSIgCj4+
IHRoYXQgd2l0aCBkZWZpbml0aW9uIG91dHB1dCBpZiB0aGUgaW5wdXQgZXZlbnQgYXJlIGFsbCBy
ZWd1bGFyIGFuZAo+PiB3aXRob3V0IHJhbmRvbT8KPj4gCj4KPldlbGwsIGlmIHlvdSBvbmx5IHdh
bnQgZGV0ZXJtaW5pc20gYW5kIG5vdCBhY2N1cmFjeSwgaXQgbWlnaHQgYmUKPnBvc3NpYmxlLCBi
dXQgSSBoYXZlIHRvIGFkbWl0IHRvIHlvdSB0aGF0IEkndmUgbmV2ZXIgdHJpZWQgdG8gaW5zdHJ1
bWVudAo+b3IgbWVhc3VyZSB0aGlzLiBJIGFzc3VtZSB0aGVyZSBhcmUgbWFueSBwbGFjZXMgd2hl
cmUgY3ljbGUKPmluZGV0ZXJtaW5hbmN5IGNvbWVzIGluIGZyb20gdGhlIGhvc3Qgc3lzdGVtLgo+
Cj5BbmQgSSB0cnVzdCB4ODYgYWJvdXQgYXMgZmFyIGFzIEkgY2FuIHRocm93IGl0Lgo+Cj5JIGFz
c3VtZSB0aGVyZSBhcmUgbWFueSBiYXJyaWVycyB0byB0aGlzLCBidXQgbWF5YmUgZm9sa3Mgd2hv
IHdvcmtlZCBvbgo+dGhlIHJlcGxheSBkZWJ1Z2dlciBjb3VsZCBnaXZlIHNvbWUgbW9yZSBhdXRo
b3JpdGF0aXZlIGlkZWEuCj4KPgo+PiB0aGFuayB5b3UKPj4gCg==
------=_Part_12226_1848168320.1589417805164
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS43O2NvbG9yOiMwMDAwMDA7Zm9udC1zaXplOjE0cHg7
Zm9udC1mYW1pbHk6QXJpYWwiPjxwIHN0eWxlPSJtYXJnaW46IDA7Ij5UaGFuayB5b3UsIG11Y2gg
YXBwcmVjaWF0ZSB5b3VyIHRob3VnaHQgYW5kIG1lYW5pbmdmdWwgZm9yIG1lITwvcD48cCBzdHls
ZT0ibWFyZ2luOiAwOyI+PGJyPjwvcD48cCBzdHlsZT0ibWFyZ2luOiAwOyI+PGJyPjwvcD48cCBz
dHlsZT0ibWFyZ2luOiAwOyI+PGJyPjwvcD48cCBzdHlsZT0ibWFyZ2luOiAwOyI+PGJyPjwvcD48
ZGl2IHN0eWxlPSJwb3NpdGlvbjpyZWxhdGl2ZTt6b29tOjEiPjwvZGl2PjxkaXYgaWQ9ImRpdk5l
dGVhc2VNYWlsQ2FyZCI+PC9kaXY+PHAgc3R5bGU9Im1hcmdpbjogMDsiPjxicj48L3A+PHByZT48
YnI+QXQgMjAyMC0wNS0xNCAwNzoyMjoxMiwgIkpvaG4gU25vdyIgJmx0O2pzbm93QHJlZGhhdC5j
b20mZ3Q7IHdyb3RlOgomZ3Q7CiZndDsKJmd0O09uIDUvMTEvMjAgMTA6MDcgQU0sIHR1Z291eHAg
d3JvdGU6CiZndDsmZ3Q7IEhpIGZvbGtzOgomZ3Q7Jmd0OyAmbmJzcDsgaSB3YW50IHRvIGtub3cg
YWJvdXQgd2hldGhlciB0aGVyciBhcmUgbGltaXRhdGlvbnMgZHVyaW5nIHFlbXUKJmd0OyZndDsg
ZW11bGF0aW9uIHN5c3RlbXMsIGZvciBleGFtcGUsIGRpZCB0aGUgcmVndWxhciBidWdzIGNvcmVu
ZXIgY2FzZSBjYW50IGJlCiZndDsmZ3Q7IGR1cGxpY2F0ZWQgb24gcWVtZSBidXQgZXhpc3Qgb24g
cmVhbCBib2Fkcz8KJmd0OyZndDsgCiZndDsKJmd0O0l0J3MgcG9zc2libGUsIHllcy4gUUVNVSBl
bXVsYXRlcyBpbnN0ZWFkIG9mIHNpbXVsYXRlcy4gV2UgZG8gbm90IHRyeSB0bwomZ3Q7cmVwcm9k
dWNlIGFjY3VyYXRlIGN5Y2xlIHRpbWluZ3MuIFRoZXJlIG1heSBiZSBidWdzIHRoYXQgZXhpc3Qg
aW4gcmVhbAomZ3Q7aGFyZHdhcmUgYnV0IGRvbid0IHJlcHJvZHVjZSB3aXRoIFFFTVUsIG9yLCBv
ZiBjb3Vyc2UsIHRoZSBvdGhlciB3YXkgYXJvdW5kLgomZ3Q7CiZndDsmZ3Q7IHdoeSB0aGluZyB0
aGlzIGlzIHRoYXQgLCBpIGhhdmUgZXZlciB1c2UgaGRsIHNpbXVsYXRvciAobW9kc2ltIGFuZAom
Z3Q7Jmd0OyBpdmVyaWxvZykgYW5kIG9wZW5yaXNjIHByb2Nlc3NvciB0byBlbXVsYXRlIHRoZSBs
aW51eCBhbmQgdWNvcyBydW5uaW5nLAomZ3Q7Jmd0OyBhbmQgc2VlIHRoZSB3YXZlZm9ybSBvZiB0
aGUgc2ltdWxhdGVpb24gcHJvY2VzcyBvZiB0aGUgb3BlcmF0aW9ucyBzeXN0ZW1zLgomZ3Q7Jmd0
OyBpIGZvdW5kIGFuIGludGVyZXN0aW5nIHRoaW5ncywgaWYgaSB0YWtlIGp1c3QgdGhlIHRpY2sg
aW50ZXJydXB0IGFzIHRoZQomZ3Q7Jmd0OyBvbmx5IHRlc3RiZWNoIGV2ZW50IHNvdXJjZSx0aGUm
bmJzcDsga2VybmVsIHNpbXVsYXRpb24gd2F2ZWZvcm0gaXMgaWRlbnRpY2FsCiZndDsmZ3Q7IGR1
cGxpY2F0ZWQgYWdhaW4gYW5kIGFnYWluLCB3aGljaCBtZWFucyBpIGNhbiBwcmVkaWNhdGUgZnV0
dXJlIGJlaGF2aW9yLgomZ3Q7Jmd0OyAKJmd0OwomZ3Q7WWVhaCwgd2UgYXJlIG5vdCBvcGVyYXRp
bmcgb24gdGhlIHZlcmlsb2cgbGV2ZWwgZm9yIGFueSBvZiB0aGUgaGFyZHdhcmUKJmd0O3dlIGVt
dWxhdGUuCiZndDsKJmd0OyZndDsgaSB0aGluayB0aGlzIHNvbWV0aGluZyBsaWtlIHFlbXUgd29y
ayBwcmluY2lwbGUgYW5kIHNvIHdhbnQgdG8ga25vdywKJmd0OyZndDsgd2hldGhlciB0aGUgcWVt
dSBoYXMgdGhpcyBsaW1pdGF0aW9uPyBpcyB0aGUgc2ltdWxhdGlvbiBwcm9jZXMgYSAiRlNNIiZu
YnNwOwomZ3Q7Jmd0OyB0aGF0IHdpdGggZGVmaW5pdGlvbiBvdXRwdXQgaWYgdGhlIGlucHV0IGV2
ZW50IGFyZSBhbGwgcmVndWxhciBhbmQKJmd0OyZndDsgd2l0aG91dCByYW5kb20/CiZndDsmZ3Q7
IAomZ3Q7CiZndDtXZWxsLCBpZiB5b3Ugb25seSB3YW50IGRldGVybWluaXNtIGFuZCBub3QgYWNj
dXJhY3ksIGl0IG1pZ2h0IGJlCiZndDtwb3NzaWJsZSwgYnV0IEkgaGF2ZSB0byBhZG1pdCB0byB5
b3UgdGhhdCBJJ3ZlIG5ldmVyIHRyaWVkIHRvIGluc3RydW1lbnQKJmd0O29yIG1lYXN1cmUgdGhp
cy4gSSBhc3N1bWUgdGhlcmUgYXJlIG1hbnkgcGxhY2VzIHdoZXJlIGN5Y2xlCiZndDtpbmRldGVy
bWluYW5jeSBjb21lcyBpbiBmcm9tIHRoZSBob3N0IHN5c3RlbS4KJmd0OwomZ3Q7QW5kIEkgdHJ1
c3QgeDg2IGFib3V0IGFzIGZhciBhcyBJIGNhbiB0aHJvdyBpdC4KJmd0OwomZ3Q7SSBhc3N1bWUg
dGhlcmUgYXJlIG1hbnkgYmFycmllcnMgdG8gdGhpcywgYnV0IG1heWJlIGZvbGtzIHdobyB3b3Jr
ZWQgb24KJmd0O3RoZSByZXBsYXkgZGVidWdnZXIgY291bGQgZ2l2ZSBzb21lIG1vcmUgYXV0aG9y
aXRhdGl2ZSBpZGVhLgomZ3Q7CiZndDsKJmd0OyZndDsgdGhhbmsgeW91CiZndDsmZ3Q7IAo8L3By
ZT48L2Rpdj48YnI+PGJyPjxzcGFuIHRpdGxlPSJuZXRlYXNlZm9vdGVyIj48cD48YnIvPiZuYnNw
OzwvcD48L3NwYW4+
------=_Part_12226_1848168320.1589417805164--


