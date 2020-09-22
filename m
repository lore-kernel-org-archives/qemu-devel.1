Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C4AC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 00:51:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7596E23A61
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 00:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7596E23A61
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKWX3-00061L-Bn
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 20:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kKWWF-0005c1-0k
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 20:50:55 -0400
Resent-Date: Mon, 21 Sep 2020 20:50:55 -0400
Resent-Message-Id: <E1kKWWF-0005c1-0k@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21338)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kKWWB-0002PF-97
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 20:50:54 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1600735844; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=coR+dRcwx4T8kWP72lvtBoGCcbqOg8JoTx2euzwu/VqfQtccfLD3yJtcKjz9jgczhOC0yi9mOI3GEK0uHw1U2612dv97YA21DY9t89AGBHgcdETLDmqdu+G2iNWCMT63Xasi7qiqCfKNVVe3gZDKzMG57ZPk/QzXGzJG9EdCVoY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1600735844;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=/0aS1Q5IV5snmWAr0LOCFLn4sQXG6tktDAjsWgqf/fY=; 
 b=RgGYBzei19mwz4X0OW6yfUMcjugEf9qjFTIp+Tj2uOkgad+/5Q7BxDc1NGtecmf2dsfYWolRjKMD2rdZD3xTtnnxPO7fDW21Q/hdvqtJq9og5pWNUm5Id6CltbeUo828eELXYTiNOXye1dYQCGNdfHbMhjc9WUcJ0DsaSOe6zpY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1600735842775684.9698956257887;
 Mon, 21 Sep 2020 17:50:42 -0700 (PDT)
Subject: Re: [PATCH v4 00/11] capstone + disassembler patches
Message-ID: <160073584167.23987.5739705917333363444@66eaa9a8a123>
In-Reply-To: <20200921174118.39352-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richard.henderson@linaro.org
Date: Mon, 21 Sep 2020 17:50:42 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 20:50:48
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkyMTE3NDExOC4zOTM1
Mi0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2Vl
bXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBm
b3IKbW9yZSBpbmZvcm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDIwMDkyMTE3
NDExOC4zOTM1Mi0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcKU3ViamVjdDogW1BBVENI
IHY0IDAwLzExXSBjYXBzdG9uZSArIGRpc2Fzc2VtYmxlciBwYXRjaGVzCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8
fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmln
IC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3Jp
dGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9
PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRl
ZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjNkNzY0ZDMg
ZGlzYXMvY2Fwc3RvbmU6IEFkZCBza2lwZGF0YSBob29rIGZvciBzMzkweAowNGMxY2ZhIGRpc2Fz
OiBFbmFibGUgY2Fwc3RvbmUgZGlzYXNzZW1ibHkgZm9yIHMzOTB4CjkzYTJkYTUgZGlzYXM6IFNw
bGl0IG91dCBjYXBzdG9uZSBjb2RlIHRvIGRpc2FzL2NhcHN0b25lLmMKZDI5NzM2ZSBkaXNhczog
Q29uZmlndXJlIGNhcHN0b25lIGZvciBhYXJjaDY0IGhvc3Qgd2l0aG91dCBsaWJ2aXhsCmYyODM5
NTkgZGlzYXM6IENsZWFudXAgcGx1Z2luX2Rpc2FzCmIzYTU0OGUgZGlzYXM6IFVzZSBxZW11L2Jz
d2FwLmggZm9yIGJmZCBlbmRpYW4gbG9hZHMKMWI2ZTE4NSBkaXNhczogQ2xlYW4gdXAgQ1BVRGVi
dWcgaW5pdGlhbGl6YXRpb24KM2IxZjZmOSBkaXNhczogTW92ZSBob3N0IGFzbSBhbm5vdGF0aW9u
cyB0byB0Yl9nZW5fY29kZQo4NTY1MDdlIGNhcHN0b25lOiBSZXF1aXJlIHZlcnNpb24gNC4wIGZy
b20gYSBzeXN0ZW0gbGlicmFyeQphNzE0YzI4IGNhcHN0b25lOiBVcGRhdGUgdG8gdXBzdHJlYW0g
Im5leHQiIGJyYW5jaAo4MjNhM2UyIGNhcHN0b25lOiBDb252ZXJ0IE1ha2VmaWxlIGJpdHMgdG8g
bWVzb24gYml0cwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS8xMSBDaGVja2luZyBjb21taXQgODIz
YTNlMmE5ZjNjIChjYXBzdG9uZTogQ29udmVydCBNYWtlZmlsZSBiaXRzIHRvIG1lc29uIGJpdHMp
CjIvMTEgQ2hlY2tpbmcgY29tbWl0IGE3MTRjMjg5MTdkYSAoY2Fwc3RvbmU6IFVwZGF0ZSB0byB1
cHN0cmVhbSAibmV4dCIgYnJhbmNoKQozLzExIENoZWNraW5nIGNvbW1pdCA4NTY1MDdlZWRjZTQg
KGNhcHN0b25lOiBSZXF1aXJlIHZlcnNpb24gNC4wIGZyb20gYSBzeXN0ZW0gbGlicmFyeSkKNC8x
MSBDaGVja2luZyBjb21taXQgM2IxZjZmOWNhM2EwIChkaXNhczogTW92ZSBob3N0IGFzbSBhbm5v
dGF0aW9ucyB0byB0Yl9nZW5fY29kZSkKNS8xMSBDaGVja2luZyBjb21taXQgMWI2ZTE4NWVlZTNl
IChkaXNhczogQ2xlYW4gdXAgQ1BVRGVidWcgaW5pdGlhbGl6YXRpb24pCldBUk5JTkc6IEJsb2Nr
IGNvbW1lbnRzIHVzZSBhIHRyYWlsaW5nICovIG9uIGEgc2VwYXJhdGUgbGluZQojNzM6IEZJTEU6
IGRpc2FzLmM6NDg6CisgICBhbiBlcnJvciByZXR1cm4gZnJvbSB7aG9zdCx0YXJnZXR9X3JlYWRf
bWVtb3J5LiAgKi8KCkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMKIzkx
OiBGSUxFOiBkaXNhcy5jOjU4OgorXkleSV5JICAgIkFkZHJlc3MgMHglIiBQUkl4NjQgIiBpcyBv
dXQgb2YgYm91bmRzLlxuIiwkCgpXQVJOSU5HOiBhcmNoaXRlY3R1cmUgc3BlY2lmaWMgZGVmaW5l
cyBzaG91bGQgYmUgYXZvaWRlZAojMjAzOiBGSUxFOiBkaXNhcy5jOjQ3OToKKyNpZiBkZWZpbmVk
KF9JTFAzMikgfHwgKF9fcmlzY3ZfeGxlbiA9PSAzMikKCnRvdGFsOiAxIGVycm9ycywgMiB3YXJu
aW5ncywgNDkwIGxpbmVzIGNoZWNrZWQKClBhdGNoIDUvMTEgaGFzIHN0eWxlIHByb2JsZW1zLCBw
bGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVz
IHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJ
TkVSUy4KCjYvMTEgQ2hlY2tpbmcgY29tbWl0IGIzYTU0OGUxOTk2ZSAoZGlzYXM6IFVzZSBxZW11
L2Jzd2FwLmggZm9yIGJmZCBlbmRpYW4gbG9hZHMpCjcvMTEgQ2hlY2tpbmcgY29tbWl0IGYyODM5
NTkxZTU4MyAoZGlzYXM6IENsZWFudXAgcGx1Z2luX2Rpc2FzKQo4LzExIENoZWNraW5nIGNvbW1p
dCBkMjk3MzZlMTEzNjYgKGRpc2FzOiBDb25maWd1cmUgY2Fwc3RvbmUgZm9yIGFhcmNoNjQgaG9z
dCB3aXRob3V0IGxpYnZpeGwpCjkvMTEgQ2hlY2tpbmcgY29tbWl0IDkzYTJkYTU4ZDk5NyAoZGlz
YXM6IFNwbGl0IG91dCBjYXBzdG9uZSBjb2RlIHRvIGRpc2FzL2NhcHN0b25lLmMpCldBUk5JTkc6
IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1
cGRhdGluZz8KIzMwOTogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0Cgp0b3RhbDogMCBlcnJvcnMsIDEg
d2FybmluZ3MsIDYwNCBsaW5lcyBjaGVja2VkCgpQYXRjaCA5LzExIGhhcyBzdHlsZSBwcm9ibGVt
cywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0
aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJ
TlRBSU5FUlMuCjEwLzExIENoZWNraW5nIGNvbW1pdCAwNGMxY2ZhMThjYTggKGRpc2FzOiBFbmFi
bGUgY2Fwc3RvbmUgZGlzYXNzZW1ibHkgZm9yIHMzOTB4KQoxMS8xMSBDaGVja2luZyBjb21taXQg
M2Q3NjRkM2QxZTdiIChkaXNhcy9jYXBzdG9uZTogQWRkIHNraXBkYXRhIGhvb2sgZm9yIHMzOTB4
KQo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoK
VGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIw
MDkyMTE3NDExOC4zOTM1Mi0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcvdGVzdGluZy5j
aGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxs
eSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVl
ZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

