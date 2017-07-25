Received: from eggs.gnu.org ([2001:4830:134:3::10]:48459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZwcB-000614-0d
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:58:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZwcA-0004Fn-1Z
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:58:55 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:35138)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dZwc9-0004FD-Qo
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:58:53 -0400
Received: by mail-wm0-x236.google.com with SMTP id c184so47341732wmd.0
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 02:58:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170717102607.GI3640@redhat.com>
References: <20170717063521.GA7393@lemon>
	<20170717090531.GA7163@stefanha-x1.localdomain>
	<CAFEAcA8kt71pbxggfLdP3-WCc8u8v5iijZBksMSq6Yss2ydgiw@mail.gmail.com>
	<20170717093944.GA18516@lemon>
	<CAFEAcA-hzAq=fP6Pndre3b4truxJFV3go0C91d702pMsLGZRrg@mail.gmail.com>
	<20170717102607.GI3640@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Jul 2017 10:58:32 +0100
Message-ID: <CAFEAcA8pH6+aTNznDS7hTDTfNniuSBWgORCaiSm=vkAbukpcLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Status and RFC of patchew testings on QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On 17 July 2017 at 11:26, Daniel P. Berrange <berrange@redhat.com> wrote:
> On Mon, Jul 17, 2017 at 11:06:12AM +0100, Peter Maydell wrote:
>> The current 'quiet' mode is not quite aimed at the same purpose:
>> it's good for interactive use where you don't want the long detail
>> of command lines but you do want some periodic indication of
>> progress through the compile. For entirely noninteractive
>> setups like travis and patchew there's no need to produce
>> what is in effect a rather verbose progress bar...
>
> For unattended automated systems though, I think running with V=1 is
> preferrable to quiet mode. When you don't have direct access to the
> test system to reproduce systems, every bit of information that you
> can get from the logs is potentially useful, including full compiler
> args. The flipside is that in other cases the verbose output can
> obscure the error messages you are after - depends what your're trying
> to debug - code problems vs build system problems.

The problem in both cases is that it makes the logs nearly
unusable. For travis, their log-pretty-printer takes forever
to try to render our enormously long build logs, to the point
where you're better off grabbing the raw text-only log.
For patchew, I basically ignore patchew compile failure emails
because it is too painful to get to the bottom of the email
where the actual error message is because of the pages and
pages and pages of useless progress output :-(

thanks
-- PMM
