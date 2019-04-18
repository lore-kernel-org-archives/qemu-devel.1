Received: from eggs.gnu.org ([209.51.188.92]:58232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hH3ec-0000lZ-8q
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 05:48:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hH3eb-0008Ou-4X
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 05:48:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35264)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hH3ea-0008O4-TZ
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 05:48:25 -0400
Received: by mail-wm1-f68.google.com with SMTP id y197so2137841wmd.0
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 02:48:24 -0700 (PDT)
References: <20190417115343.30527-1-pbonzini@redhat.com>
	<CAJSP0QWtW3L54SC2FuWwc_Eu9DQnHw0eWWM1bUtGRrwwbFTyiQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cf51d357-d9c0-3a20-1d23-7f6671d7948a@redhat.com>
Date: Thu, 18 Apr 2019 11:48:21 +0200
MIME-Version: 1.0
In-Reply-To: <CAJSP0QWtW3L54SC2FuWwc_Eu9DQnHw0eWWM1bUtGRrwwbFTyiQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] scsi-generic: prevent guest
 from exceeding SG_IO limits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-stable <qemu-stable@nongnu.org>

On 17/04/19 14:30, Stefan Hajnoczi wrote:
> On Wed, Apr 17, 2019 at 12:54 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>> Linux places a limit of UIO_MAXIOV pages on SG_IO ioctls (and if the limit
>> is exceeded, a confusing ENOMEM error is returned[1]).  Prevent the guest
>> from exceeding these limits, by capping the maximum transfer length to
>> that value in the block limits VPD page.
>>
>> [1] Oh well, at least it was easier to follow the kernel source knowing
>>     it had to end as ENOMEM...
>>
>> Cc: qemu-stable@nongnu.org
>> Cc: qemu-block@nongnu.org
>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  hw/scsi/scsi-generic.c | 17 +++++++++++++----
>>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> 

This is acually only an issue with kernels prior to 4.5, so it should be
fixed downstream instead.

Paolo
