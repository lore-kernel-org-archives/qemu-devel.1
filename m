Received: from eggs.gnu.org ([2001:4830:134:3::10]:45399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evog0-0007Bn-Mw
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:29:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evofz-0008LI-Tg
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:29:32 -0400
Received: from mail-ot0-x234.google.com ([2607:f8b0:4003:c0f::234]:37223)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1evofz-0008L1-NV
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:29:31 -0400
Received: by mail-ot0-x234.google.com with SMTP id t2-v6so627983otj.4
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 11:29:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180312223455.18124-1-ehabkost@redhat.com>
References: <20180312223455.18124-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Mar 2018 18:29:10 +0000
Message-ID: <CAFEAcA9W=CLdogF+gHUfQOy7Gb=UHg0oTLYhYMRh7S363ss9wQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] Machine queue, 2018-03-12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>

On 12 March 2018 at 22:34, Eduardo Habkost <ehabkost@redhat.com> wrote:
> The following changes since commit 6ceb1b51f05f9e1892d082960ed602dca7b6696e:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/audio-20180312-pull-request' into staging (2018-03-12 16:14:37 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>
> for you to fetch changes up to a82664f2f8b1ce2db90e644df01d7ca7845881a6:
>
>   cpu: drop unnecessary NULL check and cpu_common_class_by_name() (2018-03-12 19:33:32 -0300)
>
> ----------------------------------------------------------------
> Machine queue, 2018-03-12
>

Hi. It looks like this breaks bsd-user compilation:

/root/qemu/bsd-user/main.c: In function 'main':
/root/qemu/bsd-user/main.c:905:5: warning: implicit declaration of
function 'create' [-Wimplicit-function-declaration]
     cpu = create(cpu_type);
     ^
/root/qemu/bsd-user/main.c:905:5: warning: nested extern declaration
of 'create' [-Wnested-externs]
/root/qemu/bsd-user/main.c:905:9: warning: assignment makes pointer
from integer without a cast [enabled by default]
     cpu = create(cpu_type);
         ^

and then later it fails to link with
/root/qemu/bsd-user/main.c:905: undefined reference to `create'

thanks
-- PMM
