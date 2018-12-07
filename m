Received: from eggs.gnu.org ([2001:4830:134:3::10]:34272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gVFIz-0005l6-Qu
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 07:32:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gVFIv-0006G1-Qq
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 07:32:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gVFIv-0006FM-EJ
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 07:32:25 -0500
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
	<1543851204-41186-19-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cf29d953-6833-3b1a-be1a-2ba444d71ae6@redhat.com>
Date: Fri, 7 Dec 2018 13:32:22 +0100
MIME-Version: 1.0
In-Reply-To: <1543851204-41186-19-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 18/71] tests/libqos: embed allocators
 instead of malloc-ing them
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Laurent Vivier <laurent@vivier.eu>

On 2018-12-03 16:32, Paolo Bonzini wrote:
> qgraph will embed these objects instead of allocating them in a separate
> object.  Expose a new API "generic_alloc_init" and "generic_alloc_destroy"
> for that, and rename the existing API with s/init/new/ and s/uninit/free/.

Could you please add a sentence *why* you are doing this? ... without
that information, this just looks like a lot of unnecessary code churn...

 Thomas
