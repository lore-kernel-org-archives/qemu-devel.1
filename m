Received: from eggs.gnu.org ([2001:4830:134:3::10]:35098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1ceNn9-0005QA-Hb
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 10:16:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1ceNn6-0001hI-DG
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 10:16:19 -0500
Received: from mail.ispras.ru ([83.149.199.45]:46020)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1ceNn6-0001gz-2z
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 10:16:16 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20170214071510.6112.76764.stgit@PASHA-ISP>	
	<a268900c-a44f-fbc1-9f6e-92a127c5dcbf@redhat.com>
	<1487257950.32455.0.camel@redhat.com>
In-Reply-To: <1487257950.32455.0.camel@redhat.com>
Date: Thu, 16 Feb 2017 18:16:16 +0300
Message-ID: <002f01d28867$9e79ff10$db6dfd30$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
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
To: 'Gerd Hoffmann' <kraxel@redhat.com>, 'Paolo Bonzini' <pbonzini@redhat.com>
Cc: 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>, qemu-devel@nongnu.org, zyy@google.com, marcandre.lureau@gmail.com

> From: Gerd Hoffmann [mailto:kraxel@redhat.com]
> On Di, 2017-02-14 at 12:59 +0100, Paolo Bonzini wrote:
> > On 14/02/2017 08:15, Pavel Dovgalyuk wrote:
> > > This patch changes resetting strategy of the audio polling timer.
> > > It does not change expiration time if the timer is already set.
> > > This patch is needed to make this timer deterministic and to use execution
> > > record/replay for audio devices.
> > >
> > > audio_reset_timer is used in the function audio_vm_change_state_handler.
> > > Therefore every time VM is stopped or restarted the timer will be reset
> > > to new timeout. Virtual clock does not proceed while VM is stopped.
> > > Therefore there is no need in resetting the timeout when VM restarts.
> > >
> > > v2: updated commit message
> > > v3: now using timer_mod_anticipate function (as suggested by Yurii Zubrytskyi)
> >
> > Gerd, feel free to pick either v2 or v3.
> 
> Picked up v3 now.

Thanks!

And what about patch for audio record/replay?
http://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg00345.html

Pavel Dovgalyuk
