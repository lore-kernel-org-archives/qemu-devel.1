Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFCEC10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 11:08:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 980692133D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 11:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Yec+rCcM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 980692133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46527 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEXYl-0007ff-Sv
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 07:07:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hEWzd-0001rK-3o
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:31:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hEWza-00019q-6t
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:31:41 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:58158)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hEWzY-00018w-N8; Thu, 11 Apr 2019 06:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; 
	h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
	bh=6jPcdCh+D0eHM7v/rQNV1UNA7MLiHHVPfEZ8pRY6jMk=; 
	b=Yec+rCcM5P7pS4jbdtqOSE5pBw5UeufB6ezhk7w4j9V3FeSHgNraeq3AhJFHPc0kqSgUBbWIEc9Q2rW0B+wbtDYnd5GVKLtJaAanngktumSmD8I/RYqMnWD5RuMmLKcg+5PO8Q52ERyOWfj8G2mdAX6Pi+EyAw2eiNLUYi1O5ymp1kjB3W78D21nzgpU+l/+WNKQgVthSOVlY+bxYLc2jsZ4apAx7fz2dAznuMcm6QbYIqrkLX6PD8O8ipAfcr736jsaiGjhUYbmL1DyEFbJ/2SHJ7IPE8SRtiJ5MCg1y72duURTrwU6MesYfet11XeFzq+yYG21PY1v09JR9/ZSLg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine.igalia.com with esmtps 
	(Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
	id 1hEWzV-000311-IF; Thu, 11 Apr 2019 12:31:33 +0200
Received: from berto by mail.igalia.com with local (Exim)
	id 1hEWzV-0004vW-FD; Thu, 11 Apr 2019 12:31:33 +0200
From: Alberto Garcia <berto@igalia.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
In-Reply-To: <bc400e47-0140-1983-9a1b-16eb1f30fdb3@redhat.com>
References: <20190410152429.8076-1-berto@igalia.com>
	<bc400e47-0140-1983-9a1b-16eb1f30fdb3@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
	(i586-pc-linux-gnu)
Date: Thu, 11 Apr 2019 12:31:33 +0200
Message-ID: <w51bm1cvnne.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: Re: [Qemu-devel] [PATCH for-4.1] commit: Make base read-only if
 there is an early failure
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411103133.hskPuKvAwCYEwvbLmJFE_RaJ3tflxS5VpiPOH7JNlYE@z>

On Wed 10 Apr 2019 05:32:47 PM CEST, Eric Blake wrote:
> On 4/10/19 10:24 AM, Alberto Garcia wrote:
>> You can reproduce this by passing an invalid filter-node-name (like
>> "1234") to block-commit. In this case the base image is put in
>> read-write mode but is never reset back to read-only.
>
> Is it worth iotest coverage?

I couldn't think of any way to reproduce this that would trigger an
error on an iotest, but I think I have one now, I'll try to write
something.

Berto

