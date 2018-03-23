Received: from eggs.gnu.org ([2001:4830:134:3::10]:59190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ezLg2-0000zp-8h
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 08:20:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ezLg1-0006KC-DQ
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 08:20:10 -0400
Date: Fri, 23 Mar 2018 20:19:57 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180323121957.GM32362@xz-mi>
References: <d29ae6aa-5758-277b-b754-4e6fe7666e6b@redhat.com>
	<CAFEAcA9dHPLj6aF=JsS8dXaDWf_ONQ_A+SD1xXQO7DdsWK3yAw@mail.gmail.com>
	<6b4fbb94-2c28-27c2-17e4-b3ce593eb04d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6b4fbb94-2c28-27c2-17e4-b3ce593eb04d@redhat.com>
Subject: Re: [Qemu-devel] Regression on KVM qemu-system-aarch64 since
 "monitor: enable IO thread for (qmp & !mux) typed"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu list <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Eric Blake <eblake@redhat.com>

On Fri, Mar 23, 2018 at 01:01:43PM +0100, Auger Eric wrote:
> Hi,
> 
> On 23/03/18 11:26, Peter Maydell wrote:
> > On 23 March 2018 at 10:24, Auger Eric <eric.auger@redhat.com> wrote:
> >> Hi,
> >>
> >> I observe a regression on KVM accelerated qemu-system-aarch64:
> >>
> >> Unexpected error in kvm_device_access() at
> >> /home/augere/UPSTREAM/qemu/accel/kvm/kvm-all.c:2164:
> >> 2018-03-23T09:59:59.629439Z qemu-system-aarch64: KVM_GET_DEVICE_ATTR
> >> failed: Group 6 attr 0x000000000000c664: Device or resource busy
> >> 2018-03-23 10:00:00.085+0000: shutting down, reason=crashed
> > 
> > Can you get a backtrace for this? (I guess you'd need to fiddle
> > with the kvm_device_access() code to make it assert rather
> > than passing back the error).
> 
> OK. I will try to do so. As I could have expected, I cannot reproduce on
> a standalone qemu command line. The problem observed above is seen with
> libvirt launch which may be doing some other QMP stuff concurrently?

Maybe not concurrently inside libvirt, but after the patches AFAIK the
QMP part can be concurrent with something else or break some timing.

Anyway, sorry for that!  I'll see what I can do to help.

-- 
Peter Xu
