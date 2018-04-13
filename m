Received: from eggs.gnu.org ([2001:4830:134:3::10]:58640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f70oY-0002kL-5X
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 11:40:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f70oX-0002fr-3R
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 11:40:38 -0400
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:37994)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f70oW-0002fV-RF
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 11:40:36 -0400
Received: by mail-oi0-x233.google.com with SMTP id c3-v6so8751087oib.5
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 08:40:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <df1a9534-c1ca-972b-91a6-359685a671df@linux.vnet.ibm.com>
References: <1523629847-22369-1-git-send-email-thuth@redhat.com>
	<df1a9534-c1ca-972b-91a6-359685a671df@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Apr 2018 16:40:15 +0100
Message-ID: <CAFEAcA_2LLy5o4DnDw_7X-ZMKfvw=CXdADtH_DaGh3mNQSC50w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.13] pc-bios/s390-ccw: size_t should
 be unsigned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>, Collin Walling <walling@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 13 April 2018 at 16:28, Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
>
>
> On 04/13/2018 04:30 PM, Thomas Huth wrote:
>> "size_t" should be an unsigned type - the signed counterpart is called
>> "ssize_t" in the C standard instead. Thus we should also use this
>
> The first sentence sounds like ssize_t is too a type defined by some
> C standard. Is it or does ssize_t come form somewhere else? I find negative
> size a little difficult conceptually.

I think ssize_t is from POSIX:
http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/sys_types.h.html
"Used for a count of bytes or an error indication".

thanks
-- PMM
