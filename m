Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F6CC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 15:19:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8697208E3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 15:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Kzi+fv5O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8697208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgsf0-0004jr-Iq
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 11:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51856)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berto@igalia.com>) id 1hgsWn-0007O7-1f
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:11:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1hgsWj-0002Fm-73
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:11:03 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:43402)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1hgsWe-00022k-49; Fri, 28 Jun 2019 11:10:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=9KodD66SxdDdEvmzZPJFmN9ZOuuH25Q+ftNvyfrH4lY=; 
 b=Kzi+fv5OCBA24aO15xgKK/nfdeL83K6CrjD5OAc0urp1HOEqTGw67U1urRBArtmPNN+XoD6eROGQmIcpIcEG4DI5HsJLiCW0OLi5QgWmUZu+p3wwqKq59h4KgVoFVTqel4zWE/uqqWWT2dw5bmyj/MJapc2THm1+a4h/hdsk5v3Jmlci+92ZBvIMjocPBlaHygXf8VT0uAd6hCAmEcXsXhJIsEBQArhEYnTnYXiGmQBzXcaNKk9oCxSDIurGzgtwRkfxeMNn/LqsdjLYJNRo8gFooiOChuFsCugww9f5C5N3ZTq+ftx+eItiWvZf1KBFiaEU7EK5tr9Z3Ot9083Diw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1hgsWV-0001L8-L0; Fri, 28 Jun 2019 17:10:47 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1hgsWV-00020M-Ig; Fri, 28 Jun 2019 17:10:47 +0200
From: Alberto Garcia <berto@igalia.com>
To: Denis Lunev <den@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>
In-Reply-To: <7452ca4a-c552-a912-a865-d99aaad99488@virtuozzo.com>
References: <20190627135914.xlzohrdwr6mz2aq3@perseus.local>
 <4453cfc4-cff7-c004-1f4c-7cab462e4661@virtuozzo.com>
 <w51a7e3domn.fsf@maestria.local.igalia.com>
 <434b102d-9d8e-ccc2-cb53-7f49a3fbd6fb@virtuozzo.com>
 <w51r27dixcm.fsf@maestria.local.igalia.com>
 <20190628145708.GN5179@dhcp-200-226.str.redhat.com>
 <w51o92hiwi2.fsf@maestria.local.igalia.com>
 <7452ca4a-c552-a912-a865-d99aaad99488@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Fri, 28 Jun 2019 17:10:47 +0200
Message-ID: <w51lfxliw3s.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: Re: [Qemu-devel] [RFC] Re-evaluating subcluster allocation for
 qcow2 images
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
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri 28 Jun 2019 05:03:13 PM CEST, Denis Lunev wrote:
> On 6/28/19 6:02 PM, Alberto Garcia wrote:
>>>>> Please note, I am not talking now about your case with COW. Here the
>>>>> allocation is performed on the sub-cluster basis, i.e. the abscence of
>>>>> the sub-cluster in the image means hole on that offset. This is
>>>>> important difference.
>>>> I mentioned the possibility that if you have a case like 2MB / 64KB
>>>> and you write to an empty cluster then you could allocate the
>>>> necessary subclusters, and additionally fallocate() the space of the
>>>> whole cluster (2MB) in order to try to keep it contiguous.
>>>>
>>>> With this we would lose the space saving advantage of having
>>>> subclusters. But perhaps that would work for smaller cluster sizes
>>>> (it would mitigate the fragmentation problem).
>>> There seem to be use cases for both ways. So does this need to be an
>>> option?
>> Probably a runtime option, or a heuristic that decides what to do
>> depending on the cluster size.
> no, I think that this should be on-disk option as this affects
> allocation strategy.

But why does it need to be stored on-disk? It should be theoretically
possible to switch between on strategy and the other at runtime (not
that it would make sense though).

Berto

