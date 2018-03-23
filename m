Received: from eggs.gnu.org ([2001:4830:134:3::10]:53581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ezLOk-0007dH-Tu
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 08:02:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ezLOg-0001gh-2m
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 08:02:18 -0400
References: <d29ae6aa-5758-277b-b754-4e6fe7666e6b@redhat.com>
	<CAFEAcA9dHPLj6aF=JsS8dXaDWf_ONQ_A+SD1xXQO7DdsWK3yAw@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <6b4fbb94-2c28-27c2-17e4-b3ce593eb04d@redhat.com>
Date: Fri, 23 Mar 2018 13:01:43 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9dHPLj6aF=JsS8dXaDWf_ONQ_A+SD1xXQO7DdsWK3yAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu list <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>

Hi,

On 23/03/18 11:26, Peter Maydell wrote:
> On 23 March 2018 at 10:24, Auger Eric <eric.auger@redhat.com> wrote:
>> Hi,
>>
>> I observe a regression on KVM accelerated qemu-system-aarch64:
>>
>> Unexpected error in kvm_device_access() at
>> /home/augere/UPSTREAM/qemu/accel/kvm/kvm-all.c:2164:
>> 2018-03-23T09:59:59.629439Z qemu-system-aarch64: KVM_GET_DEVICE_ATTR
>> failed: Group 6 attr 0x000000000000c664: Device or resource busy
>> 2018-03-23 10:00:00.085+0000: shutting down, reason=crashed
> 
> Can you get a backtrace for this? (I guess you'd need to fiddle
> with the kvm_device_access() code to make it assert rather
> than passing back the error).

OK. I will try to do so. As I could have expected, I cannot reproduce on
a standalone qemu command line. The problem observed above is seen with
libvirt launch which may be doing some other QMP stuff concurrently?

Thanks

Eric
> 
> thanks
> -- PMM
> 
