Received: from eggs.gnu.org ([209.51.188.92]:54553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gsA8M-0001Oh-Gm
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 12:40:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gsA8L-0003A9-Fo
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 12:40:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gsA8L-00039X-7s
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 12:40:13 -0500
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
	<1549562254-41157-47-git-send-email-pbonzini@redhat.com>
	<3a979817-5418-24b0-8568-fa6aa1de20e0@ilande.co.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fa408b1e-d0ee-a54d-05d7-380f784ea1ba@redhat.com>
Date: Fri, 8 Feb 2019 18:40:03 +0100
MIME-Version: 1.0
In-Reply-To: <3a979817-5418-24b0-8568-fa6aa1de20e0@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 46/51] sparc-softmmu.mak: express
 dependencies with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, philmd@redhat.com

On 08/02/19 18:33, Mark Cave-Ayland wrote:
>> +# Uncomment the following lines to disable these optional devices:
>> +#
>> +#CONFIG_TCX=n
>> +#CONFIG_CG3=n
> What do you mean by optional here? The video card that is selected is built-in to the
> machine so is this comment eluding to a headless sun4m machine started with
> -nodefaults or similar?
> 

Yes, it means that you can build a QEMU without those, for example if
you want to have only cg3 or you are okay with requiring -nodefaults.

Basically if there is a way to run QEMU without those devices, they are
marked as optional (and use "imply" rather than "select").

Later on we might have a way to autogenerate these .mak files, and add a
help message to the Kconfig files that will be copied in the .mak files.
 For now, if it breaks you keep both pieces, but at least we guarantee
that disabling optional devices will still result in a QEMU that starts
the machine with -nodefaults.

Paolo
