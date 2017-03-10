Received: from eggs.gnu.org ([2001:4830:134:3::10]:51882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cmJ2V-0007pw-9k
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 06:48:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cmJ2T-000719-VW
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 06:48:55 -0500
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:38505)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cmJ2T-00070m-LO
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 06:48:53 -0500
Received: by mail-wm0-x236.google.com with SMTP id t189so8710812wmt.1
	for <qemu-devel@nongnu.org>; Fri, 10 Mar 2017 03:48:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170310114531.GB2480@work-vm>
References: <20170310012339.GA7400@flamenco> <20170310114531.GB2480@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Mar 2017 12:48:31 +0100
Message-ID: <CAFEAcA9s0tHLYFwm+SP22ecB9uw1oyXdJSf5iG0iKzwRQuoGpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Benchmarking linux-user performance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "Emilio G. Cota" <cota@braap.org>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=EF=BF=BDe?= <alex.bennee@linaro.org>, qemu-devel <qemu-devel@nongnu.org>

On 10 March 2017 at 12:45, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> * Emilio G. Cota (cota@braap.org) wrote:
>>                      x86_64 NBench Floating Point Performance
>>                   Host: Intel(R) Xeon(R) CPU E5-2690 0 @ 2.90GHz
>>
>>   1.88 +-+-+---+--+---+---+---+--+---+---+---+---+--+---+---+---+--+---+-+-+
>>        |   +   +  +  *A*#*A*  +  +   +   +   +   +  +   +   +   +  +   +   |
>>   1.86 +-+           *** ***                                             +-+
>>        |            #       #   *A*#***                                    |
>>        |      *A*# #         # ##   *A*                                    |
>>   1.84 +-+    #  *A*         *A*      #                                  +-+
>>        |      #                        #                              *A*  |
>>   1.82 +-+   #                          #                            ##  +-+
>>        |     #                          *A*#                        #      |
>>    1.8 +-+  #                               #  #*A*               *A*    +-+
>>        |    #                               *A*   #                #       |
>>   1.78 +-+*A*                                      #       *A*    #      +-+
>>        |                                           #   ***#  #    #        |
>>        |                                           *A*#*A*    #  #         |
>>   1.76 +-+                                         ***         # #       +-+
>>        |   +   +  +   +   +   +  +   +   +   +   +  +   +   +  *A* +   +   |
>>   1.74 +-+-+---+--+---+---+---+--+---+---+---+---+--+---+---+---+--+---+-+-+
>>          v1.v1.v1.2v1.3v1.4v1.v1.6v1.7v2.0v2.1v2.v2.3v2.4v2.5v2.v2.7v2.8.0
>>                                    QEMU version
>
> I'm assuming the dips are where QEMU fixed something and cared about corner
> cases/accuracy?

Given the scale on the LHS is from 1.74 to 1.88 my guess is that the
variation is in large part noise and the major thing is "our fp
performance is bounded by softfloat, which doesn't change and is
always very slow".

thanks
-- PMM
