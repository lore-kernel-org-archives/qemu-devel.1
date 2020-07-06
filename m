Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D53C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 18:33:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8679B20663
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 18:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8679B20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsVvU-0000Ho-S2
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 14:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jsVu6-0007mR-C6
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 14:31:46 -0400
Resent-Date: Mon, 06 Jul 2020 14:31:46 -0400
Resent-Message-Id: <E1jsVu6-0007mR-C6@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21308)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jsVu3-0005lc-AV
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 14:31:46 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1594060296; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Ww2QepvfC1OBILrxZrExwY4WBbF6Pm3n0yxZWC1vV5X7H0B8fET1BtRdHEUu6k/AhXQlCyptPWyRClAKpvFUFEiBDC8l6O9bNFRJ96ELniGP+0dpptjC8HX+2EPqmd6PYFJb0TIL1++usQUEg1Cn/oi7ArOl+edK0z8KZWbmu34=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1594060296;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=x85Iv9mvRNKH7bmPM6UM+qSRI11KDkotC2g/Lxgstzo=; 
 b=n3uq9vpkxW2sXeOyn54NP4TgZy06mukV7+CzJfCodER8v+d9KdPqLgHSiVzNKwKKCTjMLnj7eTbdHOf6CUaV/kIjMuv3yT4CyArqAKwhj0H/vIbIP1uLdbe/kPFK1TVj6m0YEnXSI9Z5qI+97Jn0/fJ/68dZEA96D87bNK+oNUA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 159406029436936.268784869845604;
 Mon, 6 Jul 2020 11:31:34 -0700 (PDT)
Message-ID: <159406029325.7847.603812553513904929@d1fd068a5071>
Subject: Re: [PATCH] chardev: don't abort on attempt to add duplicated chardev
In-Reply-To: <20200706182156.334207-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: marcandre.lureau@redhat.com
Date: Mon, 6 Jul 2020 11:31:34 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 13:19:51
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: eric.auger@redhat.com, qemu-devel@nongnu.org, marcandre.lureau@redhat.com,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDcwNjE4MjE1Ni4zMzQy
MDctMS1tYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFp
bGVkIHRoZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0
ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tl
ciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0g
VEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFr
ZSBkb2NrZXItaW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0
LW1pbmd3QGZlZG9yYSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBD
QyAgICAgIGh3L2FjcGkvaXBtaS5vCiAgQ0MgICAgICBody9hY3BpL2FjcGktc3R1Yi5vCi90bXAv
cWVtdS10ZXN0L3NyYy9jaGFyZGV2L2NoYXIuYzogSW4gZnVuY3Rpb24gJ2NoYXJkZXZfbmV3JzoK
L3RtcC9xZW11LXRlc3Qvc3JjL2NoYXJkZXYvY2hhci5jOjEwMDE6OTogZXJyb3I6IGltcGxpY2l0
IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uICdvYmplY3RfcHJvcGVydHlfdHJ5X2FkZF9jaGlsZCc7
IGRpZCB5b3UgbWVhbiAnb2JqZWN0X3Byb3BlcnR5X2FkZF9jaGlsZCc/IFstV2Vycm9yPWltcGxp
Y2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogMTAwMSB8ICAgICAgICAgb2JqZWN0X3Byb3BlcnR5
X3RyeV9hZGRfY2hpbGQoZ2V0X2NoYXJkZXZzX3Jvb3QoKSwgaWQsIG9iaiwgJmxvY2FsX2Vycik7
CiAgICAgIHwgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgogICAgICB8ICAg
ICAgICAgb2JqZWN0X3Byb3BlcnR5X2FkZF9jaGlsZAovdG1wL3FlbXUtdGVzdC9zcmMvY2hhcmRl
di9jaGFyLmM6MTAwMTo5OiBlcnJvcjogbmVzdGVkIGV4dGVybiBkZWNsYXJhdGlvbiBvZiAnb2Jq
ZWN0X3Byb3BlcnR5X3RyeV9hZGRfY2hpbGQnIFstV2Vycm9yPW5lc3RlZC1leHRlcm5zXQpjYzE6
IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlOiAqKiogWy90bXAvcWVt
dS10ZXN0L3NyYy9ydWxlcy5tYWs6Njk6IGNoYXJkZXYvY2hhci5vXSBFcnJvciAxCm1ha2U6ICoq
KiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uClRyYWNlYmFjayAobW9zdCByZWNlbnQg
Y2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkiLCBsaW5lIDY2OSwg
aW4gPG1vZHVsZT4KLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21k
KQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywg
J2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPTVhNWMx
NDYwNzc1NjQ2NDlhMTBmMzNmN2NkMzc2YTk2JywgJy11JywgJzEwMDEnLCAnLS1zZWN1cml0eS1v
cHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9Jywg
Jy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0Jywg
Jy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0nLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFy
L3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldy8uY2FjaGUvcWVtdS1kb2NrZXItY2Nh
Y2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRt
cC13M3U5Nnl3dS9zcmMvZG9ja2VyLXNyYy4yMDIwLTA3LTA2LTE0LjI4LjMxLjMyMzg5Oi92YXIv
dG1wL3FlbXU6eixybycsICdxZW11OmZlZG9yYScsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0
LW1pbmd3J10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRl
cj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTVhNWMxNDYwNzc1NjQ2NDlhMTBmMzNmN2Nk
Mzc2YTk2Cm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5n
IGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXczdTk2eXd1L3NyYycKbWFr
ZTogKioqIFtkb2NrZXItcnVuLXRlc3QtbWluZ3dAZmVkb3JhXSBFcnJvciAyCgpyZWFsICAgIDNt
My4wMzVzCnVzZXIgICAgMG04LjM4NnMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0
dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNzA2MTgyMTU2LjMzNDIwNy0xLW1hcmNhbmRyZS5s
dXJlYXVAcmVkaGF0LmNvbS90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2Fn
ZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8v
cGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVs
QHJlZGhhdC5jb20=

