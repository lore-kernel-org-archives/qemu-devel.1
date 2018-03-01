Received: from eggs.gnu.org ([2001:4830:134:3::10]:33227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1erMHl-0002hZ-3s
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:22:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1erMHg-0007Cb-7D
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:22:05 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46780 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1erMHg-0007C5-2o
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:22:00 -0500
References: <1519888086-4207-1-git-send-email-jusual@mail.ru>
	<CAJ+F1CJVyrK5PtpavMKuGwus9RC_KDjx9i2csduW9JMdV8tRbg@mail.gmail.com>
	<20180301115916.634904f3.cohuck@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f24ccad5-af69-9c3d-fd9f-b1c1ea6a70c6@redhat.com>
Date: Thu, 1 Mar 2018 12:21:57 +0100
MIME-Version: 1.0
In-Reply-To: <20180301115916.634904f3.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] use g_path_get_basename instead of basename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Julia Suvorova <jusual@mail.ru>, QEMU <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, Jim Mussared <jim@groklearning.com>, Joel Stanley <joel@jms.id.au>, Richard Henderson <rth@twiddle.net>

On 01/03/2018 11:59, Cornelia Huck wrote:
>>>
>>> Signed-off-by: Julia Suvorova <jusual@mail.ru>  
>> What about adding a warning for basename()/dirname() usage in
>> scripts/checkpatch.pl ?
> +1 to that.
> 

Good idea indeed.  Julia, would you like to send a second patch that
adds the warning?

There are already some examples (__FUNCTION__, strto*, signal, etc.)
that you can take inspiration from.

Paolo
