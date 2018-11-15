Received: from eggs.gnu.org ([2001:4830:134:3::10]:46090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gNMfE-00067K-9d
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 13:46:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gNMfD-0004c1-MU
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 13:46:52 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54285)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gNMfD-0004Wx-G7
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 13:46:51 -0500
Received: by mail-wm1-f68.google.com with SMTP id r63-v6so19910802wma.4
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 10:46:39 -0800 (PST)
References: <20181115143124.19234-1-pbonzini@redhat.com>
	<20181115143124.19234-10-pbonzini@redhat.com>
	<cc305bf4-fe14-89c0-79f3-a2051086e5f0@redhat.com>
	<eada6127-bfc8-6cc5-08ff-77a0e10c5bad@redhat.com>
	<c6916689-fcd4-aff0-3eb9-0e44b63f9d04@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fa0dac6e-3207-6dc6-efef-d7c4ce8a5ba9@redhat.com>
Date: Thu, 15 Nov 2018 19:46:36 +0100
MIME-Version: 1.0
In-Reply-To: <c6916689-fcd4-aff0-3eb9-0e44b63f9d04@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 09/10] vhost-user-test: small changes to
 init_hugepagefs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, jasowang@redhat.com, mst@redhat.com

On 15/11/2018 19:45, Philippe Mathieu-Daudé wrote:
> On 15/11/18 19:41, Paolo Bonzini wrote:
>> On 15/11/2018 15:55, Philippe Mathieu-Daudé wrote:
>>>>
>>>>        if (access(path, R_OK | W_OK | X_OK)) {
>>>>            g_test_message("access on path (%s): %s\n", path,
>>>> strerror(errno));
>>>> +        abort();
>>>>            return NULL;
>>>
>>> Can we remove the 'return NULL's now?
>>>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>
>> I can remove them, but later on the aborts will become g_test_fail and
>> the test will continue without hugepagefs.
> 
> OK, fine then!

Let's remove the returns here, and add them back together with
g_test_fail already in this series, in patch 10.

Paolo
