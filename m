Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C08C072B5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 00:54:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 990822070D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 00:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990822070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33484 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTFWO-0006Xy-Vr
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 20:54:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hTFV0-0005lD-Mt
	for qemu-devel@nongnu.org; Tue, 21 May 2019 20:52:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hTFUz-0007Xc-Q1
	for qemu-devel@nongnu.org; Tue, 21 May 2019 20:52:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:39133)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hTFUz-0007W3-IL
	for qemu-devel@nongnu.org; Tue, 21 May 2019 20:52:53 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	21 May 2019 17:52:51 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by fmsmga004.fm.intel.com with ESMTP; 21 May 2019 17:52:51 -0700
Date: Wed, 22 May 2019 08:52:20 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190522005219.GB14030@richard>
References: <20190521081227.30799-1-richardw.yang@linux.intel.com>
	<c184d4f7-686b-d54a-f969-a05ab965028a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c184d4f7-686b-d54a-f969-a05ab965028a@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.20
Subject: Re: [Qemu-devel] [PATCH] Makefile: simplify qapi-py definition with
 wildcard
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
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: berrange@redhat.com, philmd@redhat.com, qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>, kraxel@redhat.com,
	alex.bennee@linaro.org, Wei Yang <richardw.yang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 21, 2019 at 07:00:12AM -0500, Eric Blake wrote:
>On 5/21/19 3:12 AM, Wei Yang wrote:
>> All the python script in scripts/qapi is used to generate qapi code. Use
>> wildcard to simplify it.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  Makefile | 8 +-------
>>  1 file changed, 1 insertion(+), 7 deletions(-)
>
>I'm not a fan of $(wildcard). It makes your tarball creation
>non-deterministic - if there is a leftover file from development that is
>no longer part of the build, wildcard will still pick it up.  Explicit
>lists are better.  I'm inclined to NACK this, but Markus has final say
>since he maintains the qapi generator.
>

Thanks for comment.

Yes, for tarball, the order is a problem. But those python scripts are not
used in tarballs.

For leftover files, you mean those files not used and should be deleted?

-- 
Wei Yang
Help you, Help me

