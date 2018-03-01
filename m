Received: from eggs.gnu.org ([2001:4830:134:3::10]:34434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1erMLC-00059l-KC
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:25:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1erML8-0000CV-N5
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:25:38 -0500
Received: from smtp1.mail.ru ([94.100.179.111]:56134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1erML8-0000C2-9n
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:25:34 -0500
References: <1519888086-4207-1-git-send-email-jusual@mail.ru>
	<CAJ+F1CJVyrK5PtpavMKuGwus9RC_KDjx9i2csduW9JMdV8tRbg@mail.gmail.com>
	<20180301115916.634904f3.cohuck@redhat.com>
From: Julia Suvorova <jusual@mail.ru>
Message-ID: <61a53a4e-abf9-4515-4368-f60b325316b6@mail.ru>
Date: Thu, 1 Mar 2018 14:25:22 +0300
MIME-Version: 1.0
In-Reply-To: <20180301115916.634904f3.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: QEMU <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, Jim Mussared <jim@groklearning.com>, Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>



On 01.03.2018 13:59, Cornelia Huck wrote:
> On Thu, 1 Mar 2018 10:47:42 +0100
> Marc-André Lureau <marcandre.lureau@gmail.com> wrote:
> 
>> Hi
>>
>> On Thu, Mar 1, 2018 at 8:08 AM, Julia Suvorova via Qemu-devel
>> <qemu-devel@nongnu.org> wrote:
>>> basename(3) and dirname(3) modify their argument and may return
>>> pointers to statically allocated memory which may be overwritten by
>>> subsequent calls.
>>> g_path_get_basename and g_path_get_dirname have no such issues, and
>>> therefore more preferable.
>>>
>>> Signed-off-by: Julia Suvorova <jusual@mail.ru>  
>>
>> What about adding a warning for basename()/dirname() usage in
>> scripts/checkpatch.pl ?
> 
> +1 to that.
> 

Ok. I'll prepare a separate patch for that.
Thanks for the review.

>>
>> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 
