Received: from eggs.gnu.org ([2001:4830:134:3::10]:58384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cRVsO-0003lE-Ux
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 22:16:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cRVsL-00058M-Ou
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 22:16:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cRVsL-000582-JA
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 22:16:29 -0500
Date: Thu, 12 Jan 2017 11:16:21 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170112031621.GH4450@pxdev.xzpeter.org>
References: <1484112575-13194-1-git-send-email-peterx@redhat.com>
	<1484112575-13194-2-git-send-email-peterx@redhat.com>
	<20170111090607.crlxskbvhx6seyvl@kamzik.brq.redhat.com>
	<20170111095112.opwd5sy6et4qdcrl@kamzik.brq.redhat.com>
	<20170111101244.GG4450@pxdev.xzpeter.org>
	<20170111104638.die63k7v72uhgufx@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170111104638.die63k7v72uhgufx@kamzik.brq.redhat.com>
Subject: Re: [Qemu-devel] [kvm-unit-tests PATCH v5 1/2] run_tests: put logs
 into per-test file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>

On Wed, Jan 11, 2017 at 11:46:38AM +0100, Andrew Jones wrote:

[...]

> > So, how about this:
> > 
> >     rm -rf $unittest_log_dir.old || err "Failed remove old logs"
> >     if [[ -d $unittest_log_dir ]]; then
> 
> Only [ ... ] for tests like these

I thought [[ ... ]] would be superior to [ ... ] if we are not
considering the POSIX compatibility issue?

Hmm, after a quick grep, I see that kvm-unit-tests repo is using [[
... ]] only if doing any kind of pattern/regex matching, right? If so,
I'll just follow. ;-)

> 
> >         mv $unittest_log_dir $unittest_log_dir.old ||
> >             err "Failed backup logs"
> >     fi
> >     mkdir $unittest_log_dir || err "Failed to create log dir"
> > 
> > And define err() in common.bash:
> > 
> >     function err()
> >     {
> >         echo "$@"
> >         exit 1
> >     }
> 
> The above is mostly just translating rm/mv/mkdir stderr messages to
> new messages. We can do it much more simply like
> 
>  rm -rf logs.old
>  [ -d logs ] && mv logs logs.old
>  mkdir logs || exit 2

Okay I'll use this. Thanks!

-- peterx
