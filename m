Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D599BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 12:57:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FB5F20706
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 12:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB5F20706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k81Ak-0003Bx-Ty
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 08:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k81AE-0002gF-Ui
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 08:56:30 -0400
Resent-Date: Tue, 18 Aug 2020 08:56:30 -0400
Resent-Message-Id: <E1k81AE-0002gF-Ui@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21396)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k81AB-0006LB-Gk
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 08:56:30 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1597755376; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=TVR9g0oN3rnHPChZ9ktbbWsVmT2515uN3smXEwSl+/o4n5btN3BbtwbHqwRTD70v8halL8xFyujScawydU7NOHjbueRo7o3+6LgVO2K3JpXYFFx63v/Rt73DGPecqcFrNT4skQBDrl4BLReTd6U8aegt3EfmXTIM4/iTho7y4RM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1597755376;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=FAdamSNR/dieGtsjnB8XTDTGpvDZrpXtT+9ERdgp8DU=; 
 b=KMvIJHHs1N+E2hjL78ORYe0ZQ+86mXvUz5w1tyXGdUR2RPWRudWOkiQj+Rx3e23r6WVoIFauXvN+1DKMkjjPx+JfOQUMXIcZ+j9i3wrZvdEldhHDsKvcgIB9n14ZtbyKiSbU8o8HxLXwNzu6bEnDinRwdWqM0oQNO7Nf+KQw3PQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1597755372494383.6387224569395;
 Tue, 18 Aug 2020 05:56:12 -0700 (PDT)
Subject: Re: [PATCH v2 0/7] x86: fix cpu hotplug with secure boot
Message-ID: <159775537107.17412.11110752129834412055@66eaa9a8a123>
In-Reply-To: <20200818122208.1243901-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: imammedo@redhat.com
Date: Tue, 18 Aug 2020 05:56:12 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 08:56:24
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: boris.ostrovsky@oracle.com, lersek@redhat.com, qemu-devel@nongnu.org,
 aaron.young@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDgxODEyMjIwOC4xMjQz
OTAxLTEtaW1hbW1lZG9AcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhl
IGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5n
IGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0
YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBT
Q1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0x
IE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0x
IEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIFRFU1QgICAgY2hlY2st
dW5pdDogdGVzdHMvdGVzdC1jaGFyClVuZXhwZWN0ZWQgZXJyb3IgaW4gb2JqZWN0X3Byb3BlcnR5
X3RyeV9hZGQoKSBhdCAvdG1wL3FlbXUtdGVzdC9zcmMvcW9tL29iamVjdC5jOjExODE6CmF0dGVt
cHQgdG8gYWRkIGR1cGxpY2F0ZSBwcm9wZXJ0eSAnc2VyaWFsLWlkJyB0byBvYmplY3QgKHR5cGUg
J2NvbnRhaW5lcicpCkVSUk9SIHRlc3QtY2hhciAtIHRvbyBmZXcgdGVzdHMgcnVuIChleHBlY3Rl
ZCAzOCwgZ290IDkpCm1ha2U6ICoqKiBbY2hlY2stdW5pdF0gRXJyb3IgMQptYWtlOiAqKiogV2Fp
dGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgogIFRFU1QgICAgaW90ZXN0LXFjb3cyOiAwMjQK
ICBURVNUICAgIGlvdGVzdC1xY293MjogMDI1Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vy
cm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQg
J1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5z
dGFuY2UudXVpZD1mMmI1MmU3NzllYTA0NGE2YWY4MzQ3YWU0OWQ0Nzg1ZScsICctdScsICcxMDAx
JywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywg
J1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0n
LCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScsICctZScs
ICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Ly5jYWNo
ZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAv
cGF0Y2hldy10ZXN0ZXItdG1wLWU2NTF4NGE4L3NyYy9kb2NrZXItc3JjLjIwMjAtMDgtMTgtMDgu
NDMuMDQuMjMzMjE6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXUvY2VudG9zNycsICcvdmFyL3Rt
cC9xZW11L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVz
IDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPWYyYjUyZTc3
OWVhMDQ0YTZhZjgzNDdhZTQ5ZDQ3ODVlCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3Ig
MQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1w
LWU2NTF4NGE4L3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10g
RXJyb3IgMgoKcmVhbCAgICAxM203LjE0MHMKdXNlciAgICAwbTkuMzI4cwoKClRoZSBmdWxsIGxv
ZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA4MTgxMjIyMDgu
MTI0MzkwMS0xLWltYW1tZWRvQHJlZGhhdC5jb20vdGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9z
Ny8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0
Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRv
IHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

