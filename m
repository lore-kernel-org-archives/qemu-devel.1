Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF38C4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 13:08:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C7A920760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 13:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C7A920760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPmi4-0008DQ-4Q
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 09:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kPmbo-0002GV-9q; Tue, 06 Oct 2020 09:02:24 -0400
Resent-Date: Tue, 06 Oct 2020 09:02:24 -0400
Resent-Message-Id: <E1kPmbo-0002GV-9q@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21734)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kPmbg-0002bL-7t; Tue, 06 Oct 2020 09:02:23 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1601989301; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=BRSrxyNgIaYD4vRdKsvLwWwWTEru1YB5ksgOZ4xiEMEw2YukmLT0bnWJofmB3Hb3OxT3AJmNHHF0DqLp4C2yCGpUXEBYcOEvc53R6Ui8SwZadBMH+mzaYazRJGzQmRmC56NiA2yrQs+C6iWX732le3eTZEMPo3+zB+LMjqfeax4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1601989301;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=7leGuFAP1yMzzc17frrnNNQ0qgjq8eoztl3Kqyd3K1A=; 
 b=NoFabDK1BFpHgfLqI3xEmN5EA5sgZrdFYgjblR05B/ynr2FygIJI8hndAAFIiKsEbJSoIWQx6l9bXjaMssWavgYobNDY+hZcnA2iU/UeFbp+4WS6ss8rQdQpgehArv4DX4ld6zJU7TvjWf7w8vM/4PBM6qE/CkwjostI9rE+gns=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1601989297120351.6086671881201;
 Tue, 6 Oct 2020 06:01:37 -0700 (PDT)
Subject: Re: [PATCH v7 00/13] Fix scsi devices plug/unplug races w.r.t
 virtio-scsi iothread
Message-ID: <160198929459.31697.15378274456969070710@66eaa9a8a123>
In-Reply-To: <20201006123904.610658-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mlevitsk@redhat.com
Date: Tue, 6 Oct 2020 06:01:37 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 09:01:22
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, lvivier@redhat.com, thuth@redhat.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, mst@redhat.com,
 jasowang@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanb@linux.ibm.com, pbonzini@redhat.com, mlevitsk@redhat.com,
 jsnow@redhat.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMTAwNjEyMzkwNC42MTA2
NTgtMS1tbGV2aXRza0ByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhh
dmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUg
aW5mb3JtYXRpb246CgpOL0EuIEludGVybmFsIGVycm9yIHdoaWxlIHJlYWRpbmcgbG9nIGZpbGUK
CgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8y
MDIwMTAwNjEyMzkwNC42MTA2NTgtMS1tbGV2aXRza0ByZWRoYXQuY29tL3Rlc3RpbmcuY2hlY2tw
YXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkg
UGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNr
IHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

