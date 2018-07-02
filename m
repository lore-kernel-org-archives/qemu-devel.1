Received: from eggs.gnu.org ([2001:4830:134:3::10]:56194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fa4Q2-0006E7-MU
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 15:23:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fa4Px-00040u-Rg
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 15:23:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48116 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fa4Px-00040S-NU
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 15:23:21 -0400
References: <153055056654.212317.4697363278304826913.stgit@bahia.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <72864d18-e647-4070-bcb4-cbfca67ede8d@redhat.com>
Date: Mon, 2 Jul 2018 14:23:19 -0500
MIME-Version: 1.0
In-Reply-To: <153055056654.212317.4697363278304826913.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] i386: fix '-cpu ?' output for host cpu type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

On 07/02/2018 11:56 AM, Greg Kurz wrote:
> Since commit d6dcc5583e7, '-cpu ?' shows the description of the
> X86_CPU_TYPE_NAME("max") for the host CPU model:

In the subject line and here, let's favor '-cpu help' as the preferred 
spelling for this command line option.  (-cpu ? requires shell quoting 
to avoid unintentionally globbing to one-letter files in the current 
directory)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
