Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A04C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 18:48:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 358B821897
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 18:48:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 358B821897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAezu-0007Fn-Bx
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 14:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55605)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iAeyI-0006Wc-J4
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 14:46:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iAeyH-0005XV-Dd
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 14:46:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58160)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1iAeyE-0005Vm-MT; Wed, 18 Sep 2019 14:46:30 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DEAE520E1;
 Wed, 18 Sep 2019 18:46:29 +0000 (UTC)
Received: from [10.10.124.73] (ovpn-124-73.rdu2.redhat.com [10.10.124.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3CA0B19C5B;
 Wed, 18 Sep 2019 18:46:29 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20190912135632.13925-1-mreitz@redhat.com>
 <20190912135632.13925-5-mreitz@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <377314de-2a77-0fe7-e5ea-07f368c504ec@redhat.com>
Date: Wed, 18 Sep 2019 14:46:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190912135632.13925-5-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Wed, 18 Sep 2019 18:46:29 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 4/4] iotests: Add test for failing mirror
 complete
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/12/19 9:56 AM, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/041     | 44 ++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/041.out |  4 ++--
>   2 files changed, 46 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
> index 8568426311..84bc6d6581 100755
> --- a/tests/qemu-iotests/041
> +++ b/tests/qemu-iotests/041
> @@ -1121,6 +1121,50 @@ class TestOrphanedSource(iotests.QMPTestCase):
>                                target='dest-ro')
>           self.assert_qmp(result, 'error/class', 'GenericError')
>   
> +    def test_failing_permission_in_complete(self):
> +        self.assert_no_active_block_jobs()
> +
> +        # Unshare consistent-read on the target
> +        # (The mirror job does not care)
> +        result = self.vm.qmp('blockdev-add',
> +                             driver='blkdebug',
> +                             node_name='dest-perm',
> +                             image='dest',
> +                             unshare_child_perms=['consistent-read'])
> +        self.assert_qmp(result, 'return', {})
> +
> +        result = self.vm.qmp('blockdev-mirror', job_id='job', device='src',
> +                             sync='full', target='dest',
> +                             filter_node_name='mirror-filter')
> +        self.assert_qmp(result, 'return', {})
> +
> +        # Require consistent-read on the source
> +        # (We can only add this node once the job has started, or it
> +        # will complain that it does not want to run on non-root nodes)
> +        result = self.vm.qmp('blockdev-add',
> +                             driver='blkdebug',
> +                             node_name='src-perm',
> +                             image='src',
> +                             take_child_perms=['consistent-read'])
> +        self.assert_qmp(result, 'return', {})
> +
> +        # While completing, mirror will attempt to replace src by
> +        # dest, which must fail because src-perm requires
> +        # consistent-read but dest-perm does not share it; thus
> +        # aborting the job when it is supposed to complete
> +        self.complete_and_wait('job',
> +                               completion_error='Operation not permitted')
> +
> +        # Assert that all of our nodes are still there (except for the
> +        # mirror filter, which should be gone despite the failure)
> +        nodes = self.vm.qmp('query-named-block-nodes')['return']
> +        nodes = list(map(lambda image: image['node-name'], nodes))

Sadly, the list comprehension is a good suggestion. Squash it in if 
you'd like.

> +
> +        for expect in ['src', 'src-perm', 'dest', 'dest-perm']:
> +            self.assertTrue(expect in nodes, '%s disappeared' % expect)

I could be a real weenie and say "why not use a tuple here?"

but, I'll only pretend I didn't say that instead of couching it in a 
self-deprecating wrapper to the same end effect.

(I'm a weenie.)

> +        self.assertFalse('mirror-filter' in nodes,
> +                         'Mirror filter node did not disappear')
> +
>   if __name__ == '__main__':
>       iotests.main(supported_fmts=['qcow2', 'qed'],
>                    supported_protocols=['file'])
> diff --git a/tests/qemu-iotests/041.out b/tests/qemu-iotests/041.out
> index 2c448b4239..f496be9197 100644
> --- a/tests/qemu-iotests/041.out
> +++ b/tests/qemu-iotests/041.out
> @@ -1,5 +1,5 @@
> -..........................................................................................
> +...........................................................................................
>   ----------------------------------------------------------------------
> -Ran 90 tests
> +Ran 91 tests
>   
>   OK
> 

Or don't do anything, because I'm just being obnoxious, and I owe you 
one for giving you bad advice last round.

Reviewed-by: John Snow <jsnow@redhat.com>

