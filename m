Received: from eggs.gnu.org ([2001:4830:134:3::10]:34003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eol1k-0003Cr-6I
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 02:10:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eol1d-0003RR-W6
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 02:10:48 -0500
Received: from mail.ispras.ru ([83.149.199.45]:54132)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eol1d-0003Qg-Ni
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 02:10:41 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180207120353.5389.54531.stgit@pasha-VirtualBox>
	<CAFXrp_fenK2mzLSOUUcWLTR1r4_jUEN07QDqfkRDpTFEo4oHpQ@mail.gmail.com>
	<002401d3a010$8d551280$a7ff3780$@ru>
	<CAFXrp_c09S6e9EnT7LOYox2YMiOXN_suFo30wfqcmzwRB8zx2A@mail.gmail.com>
	<CAFXrp_dUAZDYLUTqY0nxbGg7w4TEqD2+rNRPT+47a0B8N1Y6Aw@mail.gmail.com>
	<001b01d3a3c5$032e09f0$098a1dd0$@ru>
	<CAFXrp_dNj+BSYo+0rpv5d4PxdjJ1RL_cROaDWRvjQTLziFtO_Q@mail.gmail.com>
	<000c01d3a496$fd2bc470$f7834d50$@ru>
	<CAFXrp_cEsHH_6VQevxsrj8GTchraGKEJ_t0xhSbfajcBu-mmzg@mail.gmail.com>
	<001a01d3a4b1$273f1a90$75bd4fb0$@ru>
	<002201d3a4b5$2a642b80$7f2c8280$@ru>
	<CAFEAcA9yO_4FX0J6hsdAmV7TwZd5kp9J-B2EPwm_KZxDO25bGQ@mail.gmail.com>
	<000d01d3a590$caa17950$5fe46bf0$@ru>
	<001201d3a957$f85ed610$e91c8230$@ru>
	<CAFXrp_cR16EOwZp-FauZuZcwuWwB53gxSO57ggy5qud-vyzimA@mail.gmail.com>
	<001801d3aa2f$ac7b4160$0571c420$@ru>
	<CAFXrp_d7WDGcZ99pnfpxggYgqzHJDLRxnjNcGH1SLgbyq2Y7yQ@mail.gmail.com>
	<001401d3aadf$00d2cbc0$02786340$@ru>
	<CAFXrp_epimy5WRugYjojkuj-u=WLDaz=7_8w2D-r qjNUGZz0vw@mail.gmail
	.	com> <001201d3abab$a38b77a0$eaa266e0$@ru>
In-Reply-To: <001201d3abab$a38b77a0$eaa266e0$@ru>
Date: Thu, 22 Feb 2018 10:10:45 +0300
Message-ID: <001301d3abac$421392e0$c63ab8a0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [RFC PATCH v6 00/20] replay additions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Pavel Dovgalyuk' <dovgaluk@ispras.ru>, 'Ciro Santilli' <ciro.santilli@gmail.com>
Cc: 'Peter Maydell' <peter.maydell@linaro.org>, richard.henderson@linaro.org, "'Emilio G. Cota'" <cota@braap.org>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, 'QEMU Developers' <qemu-devel@nongnu.org>, 'Kevin Wolf' <kwolf@redhat.com>, war2jordan@live.com, 'Igor R' <boost.lists@gmail.com>, 'Juan Quintela' <quintela@redhat.com>, 'Jason Wang' <jasowang@redhat.com>, "'Michael S. Tsirkin'" <mst@redhat.com>, 'Aleksandr Bezzubikov' <zuban32s@gmail.com>, maria.klimushenkova@ispras.ru, 'Gerd Hoffmann' <kraxel@redhat.com>, 'Thomas Dullien' <thomas.dullien@googlemail.com>, 'Paolo Bonzini' <pbonzini@redhat.com>, =?UTF-8?Q?'Alex_Benn=C3=A9e'?= <alex.bennee@linaro.org>

> From: Pavel Dovgalyuk [mailto:dovgaluk@ispras.ru]
> > From: Ciro Santilli [mailto:ciro.santilli@gmail.com]
> > On Wed, Feb 21, 2018 at 6:41 AM, Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote:
> > >> From: Ciro Santilli [mailto:ciro.santilli@gmail.com]
> > >> On Tue, Feb 20, 2018 at 9:46 AM, Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote:
> > >> >
> > >> > Updated the branch on github.
> > >> > You may try it.
> > >>
> > >> At 8a482834780a131e7747c1c3c1931379ed0beedc ARM initrd record runs,
> > >> but replay is getting stuck at:
> > >>
> > >> [   12.120424] scsi host0: sym-2.2.3
> 
> Yes, I've got the same.
> But when I use -serial stdio instead of -nographic, replay makes a pause
> at this line and then continues and finishes successfully.

It doesn't stuck, but works much slower with -nographic. 
You just have to wait for 5 minutes or something to notice the progress.

Pavel Dovgalyuk
