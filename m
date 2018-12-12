Received: from eggs.gnu.org ([2001:4830:134:3::10]:33468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gX2QI-0005GH-Ry
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 06:11:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gX2QF-00058p-C5
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 06:11:26 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38220)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gX2QE-00053c-Iu
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 06:11:23 -0500
Received: by mail-wm1-f67.google.com with SMTP id m22so5506449wml.3
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 03:11:18 -0800 (PST)
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
	<1543851204-41186-20-git-send-email-pbonzini@redhat.com>
	<f525819f-816c-da64-0871-6921996b28fb@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4e7e0f95-364d-7cdf-67f8-394d1c371870@redhat.com>
Date: Wed, 12 Dec 2018 12:09:04 +0100
MIME-Version: 1.0
In-Reply-To: <f525819f-816c-da64-0871-6921996b28fb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 19/71] tests: qgraph API for the qtest
 driver framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Laurent Vivier <laurent@vivier.eu>

On 07/12/18 16:38, Thomas Huth wrote:
> I did not do a very detailed review, but from a quick glance, this looks
> quite good to me already (apart from the few minor issues that I've
> mentioned above)
> 
>  Thomas

Good, if this is okay for you, my plan is the following:

- send patches 1-18 in my next pull request to Peter

- send patches 15-19 for review as v2, for inclusion in your qtest tree

- once that is done and the patches are included in your tree, send the
more "boring" patches 20-71 directly to you as a pull request, basically
the same as in this submission only with checkpatch fixed.

Thanks,

Paolo
