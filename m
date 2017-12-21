Received: from eggs.gnu.org ([2001:4830:134:3::10]:40070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eS4TE-0001Qr-D5
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 12:17:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eS4TC-00015T-4b
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 12:17:24 -0500
Date: Thu, 21 Dec 2017 18:17:14 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171221181714.092a776f.cohuck@redhat.com>
In-Reply-To: <588a1a23-843c-c7e0-b174-8deb84b41b80@redhat.com>
References: <20171218224616.21030-1-david@redhat.com>
	<20171218224616.21030-2-david@redhat.com>
	<4ea93c11-adf5-ca1c-b49b-e80d82bf3945@redhat.com>
	<588a1a23-843c-c7e0-b174-8deb84b41b80@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 1/2] s390x/tcg: implement
 TEST PROTECTION
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On Tue, 19 Dec 2017 11:32:16 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 19.12.2017 09:20, Thomas Huth wrote:
> > On 18.12.2017 23:46, David Hildenbrand wrote:  

> >> +    /*
> >> +     * TODO: we currently don't handle all access protection types
> >> +     * (including access-list and key-controlled) as well as AR mode.
> >> +     */  
> > 
> > Maybe add some "if (a2 & 0xf0) qemu_log_mask(LOG_UNIMPL, ...)" so that
> > we've got a chance to detect such conditions later?
> >   
> 
> In general I would agree, however as such acess-list + storage key stuff
> is missing literally all over the place, I don't think it is very helpful.
> 
> Once (if ever) we implement it, we will have to go through the whole PoP
> either way and fixup all functions.

The TODO is fine with me.

Out of curiousity, do you already have an idea how much work that would
be? (Not asking for patches right now, mind you :)
