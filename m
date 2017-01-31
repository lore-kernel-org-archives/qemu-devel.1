Received: from eggs.gnu.org ([2001:4830:134:3::10]:60178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cYaMh-00039N-FY
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:29:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cYaMc-0004C0-IC
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:29:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cYaMc-0004Bt-Bn
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:28:58 -0500
References: <1485873796-15095-1-git-send-email-mst@redhat.com>
	<b1e5af37-6547-e688-0365-2bb1bfe45954@redhat.com>
	<CAFEAcA-UPQrgq8h1LbqsUWP-MKwkOBLsAk0R0u0YuSfyA=nQAg@mail.gmail.com>
	<c6c5267a-58df-061b-8dd3-73d691d37578@redhat.com>
	<CAFEAcA_rPxu8tmHn88t4odtCA1ZCK4iPsRB8+jLqk13k2u90yg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <278c72d2-669a-9591-9391-2be3ead266a8@redhat.com>
Date: Tue, 31 Jan 2017 10:28:57 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_rPxu8tmHn88t4odtCA1ZCK4iPsRB8+jLqk13k2u90yg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] QEMU_BUILD_BUG_ON: use __COUNTER__
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>



On 31/01/2017 10:26, Peter Maydell wrote:
> On 31 January 2017 at 15:16, Eric Blake <eblake@redhat.com> wrote:
>> The do-nothing fallback works for me; I'm just debating whether it is
>> dead code or whether we really would have a user building with a
>> compiler that old.
> 
> OSX 10.6's clang (whatever that was) is probably the most
> likely I'd guess.
> 
> If we did want to require a newer compiler there are a
> bunch of QEMU_GNUC_PREREQ(3,4) calls that could be
> obsoleted. But we should probably do that as a separate
> thread to get some consensus on what the minimum version
> should be, and put a helpful check in configure and
> a line in the release notes and so on...

We already require 4.1 for atomics.

Paolo
