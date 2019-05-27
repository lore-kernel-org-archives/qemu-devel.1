Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B40C04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 12:38:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 246112075E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 12:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="cGRYh0Oa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 246112075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45326 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVEto-00078K-FC
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 08:38:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hVEss-0006jB-0W
	for qemu-devel@nongnu.org; Mon, 27 May 2019 08:37:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hVEsr-00086L-5e
	for qemu-devel@nongnu.org; Mon, 27 May 2019 08:37:45 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:54826)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hVEso-0007yi-No; Mon, 27 May 2019 08:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; 
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
	bh=X7tYel9SZX6HYBkoyptPhN99hiMM5H2sPtkaSb9Y8pU=; 
	b=cGRYh0OaDy/WOBn8EgqdZVm3STy3qdvc0nNgq0MAiAk6DCHlspWQarc/1xXc8opgVKnIaYs8OStikHDlmfHQ6QqljAsfU7Awzj7FqkGhaX/3Pop+VcD4Ov0QeGmO8zNcGFz84sJcYbcpmJKWj7BeZGL8P803esfogXw+FOjxu1bGnhlRuKuOUTdd6hTGcvsCtkNm5YXySUTkxuFMyCk2iecMDSpcEc9DKf+SqsRm3xDkUSSH9N5rO4/HAnKTAEuzpiEQz/Ry+JtKmEBUVSk3GbMoG1lvW9PRORNwQu0vVdpjscdNdP1KdXmM4UiZJE8C/1XpLv0oDQevOhMRUklnFQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine.igalia.com with esmtps 
	(Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
	id 1hVEsl-0002fU-LC; Mon, 27 May 2019 14:37:39 +0200
Received: from berto by mail.igalia.com with local (Exim)
	id 1hVEsl-00007D-IO; Mon, 27 May 2019 14:37:39 +0200
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
In-Reply-To: <66e86c16-c30c-5363-ef94-f01da8979872@redhat.com>
References: <20190524172812.27308-1-mreitz@redhat.com>
	<20190524172812.27308-2-mreitz@redhat.com>
	<w51ef4ljlt7.fsf@maestria.local.igalia.com>
	<66e86c16-c30c-5363-ef94-f01da8979872@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
	(i586-pc-linux-gnu)
Date: Mon, 27 May 2019 14:37:39 +0200
Message-ID: <w515zpwrs30.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: Re: [Qemu-devel] [RFC 1/3] block: Add ImageRotationalInfo
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon 27 May 2019 02:16:53 PM CEST, Max Reitz wrote:
> On 26.05.19 17:08, Alberto Garcia wrote:
>> On Fri 24 May 2019 07:28:10 PM CEST, Max Reitz <mreitz@redhat.com> wrote:
>>> +##
>>> +# @ImageRotationalInfo:
>>> +#
>>> +# Indicates whether an image is stored on a rotating disk or not.
>>> +#
>>> +# @solid-state: Image is stored on a solid-state drive
>>> +#
>>> +# @rotating:    Image is stored on a rotating disk
>>=20
>> What happens when you cannot tell? You assume it's solid-state?
>
> When *I* cannot tell?  This field is generally optional, so in that case
> it just will not be present.
>
> (When Linux cannot tell?  I don=E2=80=99t know :-))
>
> Do you think there should be an explicit value for that?

I'll try to rephrase:

we have a new optimization that improves performance on SSDs but reduces
performance on HDDs, so this series would detect where an image is
stored in order to enable the faster code path for each case.

What happens if QEMU cannot detect if we have a solid drive or a
rotational drive? (e.g. a remote storage backend). Will it default to
enabling preallocation using write_zeroes()?

Berto

