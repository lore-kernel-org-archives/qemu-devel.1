Received: from eggs.gnu.org ([2001:4830:134:3::10]:44428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1erMuu-000884-KO
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 07:02:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1erMup-0004JM-Mu
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 07:02:32 -0500
Received: from smtp46.i.mail.ru ([94.100.177.106]:50202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1erMup-0004Ie-C3
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 07:02:27 -0500
References: <1519888086-4207-1-git-send-email-jusual@mail.ru>
	<CAJ+F1CJVyrK5PtpavMKuGwus9RC_KDjx9i2csduW9JMdV8tRbg@mail.gmail.com>
	<20180301115916.634904f3.cohuck@redhat.com>
	<f24ccad5-af69-9c3d-fd9f-b1c1ea6a70c6@redhat.com>
From: Julia Suvorova <jusual@mail.ru>
Message-ID: <e6d8caaa-8fa5-ffa9-c447-f74be604539b@mail.ru>
Date: Thu, 1 Mar 2018 15:02:24 +0300
MIME-Version: 1.0
In-Reply-To: <f24ccad5-af69-9c3d-fd9f-b1c1ea6a70c6@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, Jim Mussared <jim@groklearning.com>, Joel Stanley <joel@jms.id.au>, Richard Henderson <rth@twiddle.net>



On 01.03.2018 14:21, Paolo Bonzini wrote:
> On 01/03/2018 11:59, Cornelia Huck wrote:
>>>>
>>>> Signed-off-by: Julia Suvorova <jusual@mail.ru>  
>>> What about adding a warning for basename()/dirname() usage in
>>> scripts/checkpatch.pl ?
>> +1 to that.
>>
> 
> Good idea indeed.  Julia, would you like to send a second patch that
> adds the warning?
>  

Ok, sure.

> There are already some examples (__FUNCTION__, strto*, signal, etc.)
> that you can take inspiration from.
> 

Thanks for the tips.
