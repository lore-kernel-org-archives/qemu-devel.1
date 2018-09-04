Received: from eggs.gnu.org ([2001:4830:134:3::10]:39100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fxHFR-00004s-LU
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 15:44:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fxHFO-0005J0-Gl
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 15:44:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51260 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fxHFO-0005Ih-Bn
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 15:44:22 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7555587A84
	for <qemu-devel@nongnu.org>; Tue,  4 Sep 2018 19:44:21 +0000 (UTC)
References: <20180902175401.8195-1-ybettan@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b735a977-9591-e6c3-3e82-91db5da00188@redhat.com>
Date: Tue, 4 Sep 2018 14:44:17 -0500
MIME-Version: 1.0
In-Reply-To: <20180902175401.8195-1-ybettan@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V2 0/3] Formatted INFO files to fit
 Markdown (.md) format.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yoni Bettan <ybettan@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, stefanha@redhat.com

On 09/02/2018 12:53 PM, Yoni Bettan wrote:
> This patch make INFO files (e.g. README, CODING_STYLE and HACKING) much more
> readable when watched from GitHub GUI.
> 
> ./VERSION, ./MAINTAINERS were leave untouched otherwise
> ./scripts/get_maintainer.pl breaks.
> 
> ./COPYING, ./LICENSE ./COPYING.LIB were leave untouched because it look likes
> they come from GNU and not QEMU.
> 
> Visualization of the change can be found at
> https://github.com/ybettan/qemu/tree/md.
> NOTE:
> This last part of the message should be removed from the commit message
> since I will remove the 'md' branch from my fork if the patch is
> accepted.

I'm a bit late to the thread, but wanted to point out this tangent:

Note that the cover letter is not committed into git, so a disclaimer 
about removing the last paragraph of the cover letter is pointless.

Had this been an actual commit message, it's best to stick such 
disclaimers (which are useful to reviewers, but not to long-term git 
log) after the --- that separates the actual commit message from the 
patch (as 'git am' will automatically strip such disclaimers when a 
maintainer takes in your patch for merging through their tree).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
