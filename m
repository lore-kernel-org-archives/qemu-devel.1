Received: from eggs.gnu.org ([209.51.188.92]:39649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gvlvl-0001TL-Mt
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 11:38:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gvlvk-00078x-VJ
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 11:38:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gvlvk-000775-FQ
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 11:38:08 -0500
References: <87wom249zf.fsf@dusky.pond.sub.org>
	<8de162fa-0be0-6d40-0127-4dea571014f3@redhat.com>
	<878syd84s3.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9d50a308-fe86-7033-5e7a-1b9908c10ade@redhat.com>
Date: Mon, 18 Feb 2019 17:38:00 +0100
MIME-Version: 1.0
In-Reply-To: <878syd84s3.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Object instantiation vs. device realization: what
 to do when?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>

On 18/02/19 17:01, Markus Armbruster wrote:
> 
> Out of curiosity, what would have to be done?  Any particular problems
> other than the practical problem of manhandling 300+ qdev_init_nofail()
> calls?

Well, that's the problem.  No one knows what would break, if anything.

Paolo
