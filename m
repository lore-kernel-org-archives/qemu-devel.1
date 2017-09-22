Received: from eggs.gnu.org ([2001:4830:134:3::10]:46826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dvQFZ-0006Ak-NN
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 11:52:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dvQFU-0002ni-LA
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 11:52:21 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:49956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dvQFU-0002nL-F5
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 11:52:16 -0400
Received: by mail-wm0-f44.google.com with SMTP id r74so5162555wme.4
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 08:52:16 -0700 (PDT)
References: <1506080563-41084-1-git-send-email-pbonzini@redhat.com>
	<20170922124720.GC32000@lemon>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7a904eeb-f400-5311-e06b-65ced6d2298b@redhat.com>
Date: Fri, 22 Sep 2017 17:52:09 +0200
MIME-Version: 1.0
In-Reply-To: <20170922124720.GC32000@lemon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] docker: add installation to build tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: alex.bennee@linaro.org, qemu-devel@nongnu.org

On 22/09/2017 14:47, Fam Zheng wrote:
> On Fri, 09/22 13:42, Paolo Bonzini wrote:
>> Drop ccache on Fedora, because it fails on RHEL 7.4, it is not used
>> by any other distro and it is not particularly useful on throwaway
>> containers.
> 
> I wonder what exactly failed with ccache? Patchew relies on it to speed up
> compiling every series on the list. The ccache db is not throwaway with that in
> mind - git grep for CCACHE_DIR.

Got it.  For some reason the ccache dir in ~/.cache was owned by root.
I zapped it and now it works, so I've sent v2.

Paolo
