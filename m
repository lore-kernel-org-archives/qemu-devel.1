Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0947C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 14:41:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0EDE205C9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 14:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0EDE205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38345 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hONkh-0001Zb-Ry
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 10:40:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1hONjr-0000tZ-Q1
	for qemu-devel@nongnu.org; Wed, 08 May 2019 10:40:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1hONjm-00006z-IT
	for qemu-devel@nongnu.org; Wed, 08 May 2019 10:40:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1hONjm-00005t-Cu
	for qemu-devel@nongnu.org; Wed, 08 May 2019 10:40:02 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 56810806B6;
	Wed,  8 May 2019 14:39:59 +0000 (UTC)
Received: from localhost.localdomain (ovpn-124-185.rdu2.redhat.com
	[10.10.124.185])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C5011001E65;
	Wed,  8 May 2019 14:39:56 +0000 (UTC)
Date: Wed, 8 May 2019 10:39:53 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190508143953.GA32662@localhost.localdomain>
References: <20190503004130.8285-1-ehabkost@redhat.com>
	<20190503004130.8285-11-ehabkost@redhat.com>
	<20190508102824.ysts2k4xesxzmh67@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508102824.ysts2k4xesxzmh67@sirius.home.kraxel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Wed, 08 May 2019 14:39:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 10/19] tests/boot_linux_console: increase
 timeout
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 08, 2019 at 12:28:24PM +0200, Gerd Hoffmann wrote:
> On Thu, May 02, 2019 at 09:41:21PM -0300, Eduardo Habkost wrote:
> > From: Cleber Rosa <crosa@redhat.com>
> > 
> > When running on very low powered environments, some tests may time out
> > causing false negatives.  As a conservative change, and for
> > considering that human time (investigating false negatives) is worth
> > more than some extra machine cycles (and time), let's increase the
> > overall timeout.
> 
> Tests can also timeout due to slow downloads of test kernels.
> Any chance to run the downloads without timeout?

I acknowledge this is an issue, and have thought about two possible
ways to solve it:

 1) Downloading/caching/checking all the test assets in a job "pre-tests"
    plugin.  This would involve/require:

   - https://trello.com/c/WPd4FrIy/1479-add-support-to-specify-assets-in-test-docstring
   - https://trello.com/c/CKP7YS6G/1481-on-cache-check-for-asset-fetcher

 2) Report the test phase (say, setUp()) to the test runner, which
    would allow the runner to:

   - Not take that time into account for the test (similar to
     https://github.com/avocado-framework/avocado/pull/3076)
   - Retry the setUp a number of times (if the test opts in or doesn't
     opt out)

I'm very much interested in your opinion so we can evolve the idea into
implementation.

Thanks!
- Cleber

> 
> cheers,
>   Gerd
> 

