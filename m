Received: from eggs.gnu.org ([2001:4830:134:3::10]:34173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ceNjZ-0001q4-Nm
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 10:12:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ceNjW-0008Cu-KI
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 10:12:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ceNjW-0008CS-Ds
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 10:12:34 -0500
Message-ID: <1487257950.32455.0.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 16 Feb 2017 16:12:30 +0100
In-Reply-To: <a268900c-a44f-fbc1-9f6e-92a127c5dcbf@redhat.com>
References: <20170214071510.6112.76764.stgit@PASHA-ISP>
	<a268900c-a44f-fbc1-9f6e-92a127c5dcbf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, qemu-devel@nongnu.org, zyy@google.comdovgaluk@ispras.ru, marcandre.lureau@gmail.com

On Di, 2017-02-14 at 12:59 +0100, Paolo Bonzini wrote:
>=20
> On 14/02/2017 08:15, Pavel Dovgalyuk wrote:
> > This patch changes resetting strategy of the audio polling timer.
> > It does not change expiration time if the timer is already set.
> > This patch is needed to make this timer deterministic and to use execut=
ion
> > record/replay for audio devices.
> >=20
> > audio_reset_timer is used in the function audio_vm_change_state_handler=
.
> > Therefore every time VM is stopped or restarted the timer will be reset
> > to new timeout. Virtual clock does not proceed while VM is stopped.
> > Therefore there is no need in resetting the timeout when VM restarts.
> >=20
> > v2: updated commit message
> > v3: now using timer_mod_anticipate function (as suggested by Yurii Zubr=
ytskyi)
>=20
> Gerd, feel free to pick either v2 or v3.

Picked up v3 now.

thanks,
  Gerd
