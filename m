Received: from eggs.gnu.org ([2001:4830:134:3::10]:48884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cyZxw-0007IV-8B
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 04:18:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cyZxv-0003kR-Fu
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 04:18:56 -0400
References: <20170412173203.20072-1-lvivier@redhat.com>
	<87efwwrdki.fsf@dusky.pond.sub.org>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <ab71843b-7148-7df4-6e5a-c5585121fa1d@redhat.com>
Date: Thu, 13 Apr 2017 10:18:47 +0200
MIME-Version: 1.0
In-Reply-To: <87efwwrdki.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] arm: remove remaining
 cannot_destroy_with_object_finalize_yet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org, Antony Pavlov <antonynpavlov@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>

On 13/04/2017 09:06, Markus Armbruster wrote:
> Laurent Vivier <lvivier@redhat.com> writes:
> 
>> With commit ce5b1bbf624b ("exec: move cpu_exec_init() calls to
>> realize functions"), we can now remove all the
>> remaining cannot_destroy_with_object_finalize_yet as
>> unsafe references have been moved to cpu_exec_realizefn().
>> (tested with QOM command provided by commit 4c315c27).
> 
> Also tested with device-introspect-test :)
> 
>> Suggested-by: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> 
> Thanks, Laurent!
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 
> Just three places marking broken devices left: versatile.c
> ("realview_pci" and "versatile_pci"), target/ppc/kvm.c (various ppc
> CPUs).  Volunteers to fix them, so we can get rid of
> cannot_destroy_with_object_finalize_yet?
> 

I think I can have a look to these ones too.

Laurent
