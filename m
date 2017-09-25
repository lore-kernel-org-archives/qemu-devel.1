Received: from eggs.gnu.org ([2001:4830:134:3::10]:60210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dwTSI-0000rH-Jq
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:29:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dwTSF-000535-Gs
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:29:50 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:38414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dwTSF-00050x-Ac
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:29:47 -0400
Received: by mail-pg0-x241.google.com with SMTP id m30so4869371pgn.5
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 06:29:47 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170925112917.21340-1-dgilbert@redhat.com>
	<20170925112917.21340-2-dgilbert@redhat.com>
	<d831a4f1-2598-66c2-6e84-a9ab93cf3bff@twiddle.net>
	<20170925132514.GF2656@work-vm>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <efad6e1b-f80b-5ca6-6417-7497ddc052ef@twiddle.net>
Date: Mon, 25 Sep 2017 06:29:43 -0700
MIME-Version: 1.0
In-Reply-To: <20170925132514.GF2656@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/6] migration: pre_save return int
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, famz@redhat.com, peter.maydell@linaro.org, cohuck@redhat.com

On 09/25/2017 06:25 AM, Dr. David Alan Gilbert wrote:
>> Why not a bool?
> 
> Consistency with pre_load, post_load, put and get methods
> that are already int.

Fair enough, thanks.


r~
