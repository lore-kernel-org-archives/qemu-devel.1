Received: from eggs.gnu.org ([2001:4830:134:3::10]:53126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cdblX-0007EB-Ag
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 06:59:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cdblT-0003uF-En
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 06:59:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cdblT-0003tg-8P
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 06:59:23 -0500
References: <20170214071510.6112.76764.stgit@PASHA-ISP>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a268900c-a44f-fbc1-9f6e-92a127c5dcbf@redhat.com>
Date: Tue, 14 Feb 2017 12:59:22 +0100
MIME-Version: 1.0
In-Reply-To: <20170214071510.6112.76764.stgit@PASHA-ISP>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] audio: make audio poll timer
 deterministic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: zyy@google.com, kraxel@redhat.com, marcandre.lureau@gmail.com



On 14/02/2017 08:15, Pavel Dovgalyuk wrote:
> This patch changes resetting strategy of the audio polling timer.
> It does not change expiration time if the timer is already set.
> This patch is needed to make this timer deterministic and to use execution
> record/replay for audio devices.
> 
> audio_reset_timer is used in the function audio_vm_change_state_handler.
> Therefore every time VM is stopped or restarted the timer will be reset
> to new timeout. Virtual clock does not proceed while VM is stopped.
> Therefore there is no need in resetting the timeout when VM restarts.
> 
> v2: updated commit message
> v3: now using timer_mod_anticipate function (as suggested by Yurii Zubrytskyi)

Gerd, feel free to pick either v2 or v3.

Paolo
