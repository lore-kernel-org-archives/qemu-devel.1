Received: from eggs.gnu.org ([2001:4830:134:3::10]:58955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d5evT-0006tG-SN
	for qemu-devel@nongnu.org; Tue, 02 May 2017 17:01:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d5evP-0003Fs-PW
	for qemu-devel@nongnu.org; Tue, 02 May 2017 17:01:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d5evP-0003Fc-JK
	for qemu-devel@nongnu.org; Tue, 02 May 2017 17:01:35 -0400
Date: Tue, 2 May 2017 18:01:30 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170502210130.GG3482@thinpad.lan.raisama.net>
References: <20170502203115.22233-1-ehabkost@redhat.com>
	<149375798222.165.4208719929354027619@c05f1edc8ed1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <149375798222.165.4208719929354027619@c05f1edc8ed1>
Subject: Re: [Qemu-devel] [PATCH 0/4] x86: Support "-cpu feature=force"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: no-reply@patchew.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, agraf@suse.de, armbru@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net

On Tue, May 02, 2017 at 01:46:22PM -0700, no-reply@patchew.org wrote:
[...]
>   TEST    tests/qapi-schema/qapi-schema-test.out
>   TEST    tests/qapi-schema/quoted-structural-chars.out
>   TEST    tests/qapi-schema/redefined-builtin.out
>   TEST    tests/qapi-schema/redefined-command.out
> Files /tmp/qemu-test/src/tests/qapi-schema/qapi-schema-test.out and tests/qapi-schema/qapi-schema-test.test.out differ
> make: *** [check-tests/qapi-schema/qapi-schema-test.json] Error 1
> make: *** Waiting for unfinished jobs....

Oh, I didn't know we had a qapi-schema-test.out file that had to
be manually kept in sync. I will fix this in v2.

> tests/docker/Makefile.include:118: recipe for target 'docker-run' failed
> make[1]: *** [docker-run] Error 2
> make[1]: Leaving directory '/var/tmp/patchew-tester-tmp-mqqq0zgw/src'
> tests/docker/Makefile.include:149: recipe for target 'docker-run-test-quick@centos6' failed
> make: *** [docker-run-test-quick@centos6] Error 2
> === OUTPUT END ===
> 
> Test command exited with code: 2
> 
> 
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org

-- 
Eduardo
