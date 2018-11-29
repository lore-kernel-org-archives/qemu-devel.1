Received: from eggs.gnu.org ([2001:4830:134:3::10]:46019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gST9S-0000kE-1D
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 15:43:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gST9N-0000sf-Sc
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 15:43:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gST9N-0000nk-MN
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 15:43:05 -0500
References: <1543513531-1151-1-git-send-email-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1389c712-2e02-80c0-b9e1-4c45b54d35df@redhat.com>
Date: Thu, 29 Nov 2018 14:43:03 -0600
MIME-Version: 1.0
In-Reply-To: <1543513531-1151-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 0/2] test: replace gtester with a
 TAP driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, berrange@redhat.com

On 11/29/18 11:45 AM, Paolo Bonzini wrote:
> gtester is deprecated by upstream glib and it does not support tests
> that call g_test_skip in some glib stable releases.
> 
> glib suggests instead using Automake's TAP support.  We do not support
> Automake, but we can copy the code that beautifies the TAP output and
> use it.  I chose to use the Perl copy rather than the shell/awk one,
> in order to reuse Perl's TAP parsing package, but I'm open to suggestions
> about which language to use.

I'm less familiar with the TAP protocol than I'd like to admit, but I 
did find:

https://blog.gtk.org/2018/07/11/news-from-glib-2-58/

which corroborates your claim that switching to Automake's TAP parser is 
indeed a recommended approach to avoid the now-deprecated gtester.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
