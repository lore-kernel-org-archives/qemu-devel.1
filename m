Received: from eggs.gnu.org ([209.51.188.92]:51908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h0sWG-0002h4-Oj
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:40:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h0sWF-0003NF-Jj
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:40:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1h0sWF-0003LR-Bp
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:40:55 -0500
References: <20190304180920.21534-1-svens@stackframe.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <905f71d7-3df9-d738-3514-87a49c8aceb0@redhat.com>
Date: Mon, 4 Mar 2019 12:40:50 -0600
MIME-Version: 1.0
In-Reply-To: <20190304180920.21534-1-svens@stackframe.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/5] lsi: use ldn_le_p()/stn_le_p()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sven Schnelle <svens@stackframe.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, "open list:All patches CC here" <qemu-devel@nongnu.org>

On 3/4/19 12:09 PM, Sven Schnelle wrote:
> Signed-off-by: Sven Schnelle <svens@stackframe.org>

The commit header says "what" (good), but the commit body says nothing 
at all (generally, it should say "why"). If you give your reviewers a 
reason why it is good to use the new functions, it makes it easier to 
apply your patch.

Also, don't forget to send a 0/5 cover letter when sending a patch 
series; you can have git do this for you with 'git config 
format.coverletter auto'. https://wiki.qemu.org/Contribute/SubmitAPatch 
has more hints for improved patch handling.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
