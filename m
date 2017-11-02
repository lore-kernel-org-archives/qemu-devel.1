Received: from eggs.gnu.org ([2001:4830:134:3::10]:41309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eADek-0004Lv-6R
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 07:27:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eADeg-00038g-RO
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 07:27:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eADeg-00038A-KW
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 07:27:26 -0400
References: <20171031112457.10516.8971.stgit@pasha-VirtualBox>
	<20171031112554.10516.8584.stgit@pasha-VirtualBox>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3bb79081-1c09-b43f-fb16-dde005d741d9@redhat.com>
Date: Thu, 2 Nov 2017 12:27:16 +0100
MIME-Version: 1.0
In-Reply-To: <20171031112554.10516.8584.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 10/26] icount: fixed saving/restoring
 of icount warp timers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, alex.bennee@linaro.org

On 31/10/2017 12:25, Pavel Dovgalyuk wrote:
> +        VMSTATE_INT64(vm_clock_warp_start, TimersState),

This should be part of the icount_vmstate_warp_timer subsection.

Paolo

>          VMSTATE_END_OF_LIST()
> +    },
> +    .subsections = (const VMStateDescription*[]) {
> +        &icount_vmstate_warp_timer,
> +        &icount_vmstate_adjust_timers,
> +        NULL
>      }
>  };
>  
