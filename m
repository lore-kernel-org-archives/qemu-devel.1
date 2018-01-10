Received: from eggs.gnu.org ([2001:4830:134:3::10]:41102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eZHsg-00073e-77
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 10:01:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eZHsa-0003LG-Dj
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 10:01:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54627)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eZHsa-0003KX-7l
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 10:01:24 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 445AC68A9
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 15:01:23 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180110124723.11879-1-quintela@redhat.com> (Juan Quintela's
	message of "Wed, 10 Jan 2018 13:47:09 +0100")
References: <20180110124723.11879-1-quintela@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 10 Jan 2018 16:01:14 +0100
Message-ID: <87vag9yczp.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC 00/14] Multifd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Juan Quintela <quintela@redhat.com> wrote:
> Hi
>
> For V10:
> - It is a request for comments
>
> - I changed as suggested from Paolo on KVM forum to send page metadata
>   over the channels
>
> - I simplified lots of things
> - Added reviews
> - it is not finished, in no-particular order:
>   * old code is not removed for comparison for the people that looked at
>     the previous one
>   * it would be removed later
>   * synchronization at the end of each stage will be done with a flags field
>     on the communication channel.
> - Yes, there is commented code on the last patch.
> - I am open to suggestion about how to call the pacet "message" with
>   metadata.

Oops, somehow I sent the wrong branch, sorry.

End result is similar, but last patch have some better comments, and the
LOCAL: one was mean to be that, local for me O:-)

Sorry for the noise, Juan.
