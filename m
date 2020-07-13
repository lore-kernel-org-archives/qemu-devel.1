Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E3CC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 07:21:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2783A207DD
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 07:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EMip8RcG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2783A207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jusm8-0004hn-Bw
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 03:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1juslI-0003gS-97
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 03:20:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48550
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1juslE-0006Og-IM
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 03:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594624822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=2B24l3/07P29MKTbhmG0wjsAJQ4AjO3qFyE839RpJ6E=;
 b=EMip8RcGgIWD211W9ZkxsRddqccvzKYfqseP8CvNihGNP60k1xLstB+P5RsDrLO/oCbkoz
 mcExXLX87bXSdyAmyd9tsxClqjO/JbXxVhtFV3l6RoqeoAibuYKQpCZbfefn0u4YARDy0e
 Zv7dZVxreVHzLxC2q4DHFDa3hseoh44=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-82_75NawOjiPYpszVFj1TQ-1; Mon, 13 Jul 2020 03:20:19 -0400
X-MC-Unique: 82_75NawOjiPYpszVFj1TQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43F6D19200D3;
 Mon, 13 Jul 2020 07:20:18 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-125.ams2.redhat.com [10.36.112.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E42D7846C;
 Mon, 13 Jul 2020 07:20:03 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] GitLab Gating CI: introduce pipeline-status
 contrib script
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Erik Skultety <eskultet@redhat.com>, Cleber Rosa <crosa@redhat.com>
References: <20200709024657.2500558-1-crosa@redhat.com>
 <20200709024657.2500558-2-crosa@redhat.com>
 <20200709085519.GB536480@nautilus.usersys.redhat.com>
 <538bde71-5e96-e56d-cbcd-44cf0942590e@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <0ea6baaa-4773-4b7d-731e-580bf1acc4cd@redhat.com>
Date: Mon, 13 Jul 2020 09:20:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <538bde71-5e96-e56d-cbcd-44cf0942590e@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 03:20:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/07/2020 12.13, Philippe Mathieu-Daudé wrote:
> On 7/9/20 10:55 AM, Erik Skultety wrote:
>> On Wed, Jul 08, 2020 at 10:46:56PM -0400, Cleber Rosa wrote:
>>> This script is intended to be used right after a push to a branch.
>>>
>>> By default, it will look for the pipeline associated with the commit
>>> that is the HEAD of the *local* staging branch.  It can be used as a
>>> one time check, or with the `--wait` option to wait until the pipeline
>>> completes.
>>>
>>> If the pipeline is successful, then a merge of the staging branch into
>>> the master branch should be the next step.
>>>
>>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>>> ---
>>>  scripts/ci/gitlab-pipeline-status | 156 ++++++++++++++++++++++++++++++
>>>  1 file changed, 156 insertions(+)
>>>  create mode 100755 scripts/ci/gitlab-pipeline-status
>>>
>>> diff --git a/scripts/ci/gitlab-pipeline-status b/scripts/ci/gitlab-pipeline-status
>>> new file mode 100755
>>> index 0000000000..4a9de39872
>>> --- /dev/null
>>> +++ b/scripts/ci/gitlab-pipeline-status
>>> @@ -0,0 +1,156 @@
>>> +#!/usr/bin/env python3
>>> +#
>>> +# Copyright (c) 2019-2020 Red Hat, Inc.
>>> +#
>>> +# Author:
>>> +#  Cleber Rosa <crosa@redhat.com>
>>> +#
>>> +# This work is licensed under the terms of the GNU GPL, version 2 or
>>> +# later.  See the COPYING file in the top-level directory.
>>> +
>>> +"""
>>> +Checks the GitLab pipeline status for a given commit commit
>>
>> s/commit$/(hash|sha|ID|)
>>
>>> +"""
>>> +
>>> +# pylint: disable=C0103
>>> +
>>> +import argparse
>>> +import http.client
>>> +import json
>>> +import os
>>> +import subprocess
>>> +import time
>>> +import sys
>>> +
>>> +
>>> +def get_local_staging_branch_commit():
>>> +    """
>>> +    Returns the commit sha1 for the *local* branch named "staging"
>>> +    """
>>> +    result = subprocess.run(['git', 'rev-parse', 'staging'],
>>
>> If one day Peter decides that "staging" is not a cool name anymore and use a
>> different name for the branch :) we should account for that and make it a
>> variable, possibly even parametrize this function with it.
> 
> This script can be used by any fork, not only Peter.
> So having a parameter (default to 'staging') is a requisite IMO.
> 
>>> +                            stdin=subprocess.DEVNULL,
>>> +                            stdout=subprocess.PIPE,
>>> +                            stderr=subprocess.DEVNULL,
>>> +                            cwd=os.path.dirname(__file__),
>>> +                            universal_newlines=True).stdout.strip()
>>> +    if result == 'staging':
>>> +        raise ValueError("There's no local staging branch")
>>
>> "There's no local branch named 'staging'" would IMO be more descriptive, so as
>> not to confuse it with staging in git.
>>
>>> +    if len(result) != 40:
>>> +        raise ValueError("Branch staging HEAD doesn't look like a sha1")
>>> +    return result
>>> +
>>> +
>>> +def get_pipeline_status(project_id, commit_sha1):
>>> +    """
>>> +    Returns the JSON content of the pipeline status API response
>>> +    """
>>> +    url = '/api/v4/projects/{}/pipelines?sha={}'.format(project_id,
>>> +                                                        commit_sha1)
>>> +    connection = http.client.HTTPSConnection('gitlab.com')
>>> +    connection.request('GET', url=url)
>>> +    response = connection.getresponse()
>>> +    if response.code != http.HTTPStatus.OK:
>>> +        raise ValueError("Failed to receive a successful response")
>>> +    json_response = json.loads(response.read())
>>
>> a blank line separating the commentary block would slightly help readability
>>
>>> +    # afaict, there should one one pipeline for the same project + commit
>>
>> s/one one/be only one/
> 
> 'afaict' is not a word.
> 
>>
>>> +    # if this assumption is false, we can add further filters to the
>>> +    # url, such as username, and order_by.
>>> +    if not json_response:
>>> +        raise ValueError("No pipeline found")
>>> +    return json_response[0]
>>> +
>>> +
>>> +def wait_on_pipeline_success(timeout, interval,
>>> +                             project_id, commit_sha):
>>> +    """
>>> +    Waits for the pipeline to end up to the timeout given
>>
>> "Waits for the pipeline to finish within the given timeout"
>>
>>> +    """
>>> +    start = time.time()
>>> +    while True:
>>> +        if time.time() >= (start + timeout):
>>> +            print("Waiting on the pipeline success timed out")
>>
>> s/success//
>> (the pipeline doesn't always have to finish with success)
>>
>>> +            return False
>>> +
>>> +        status = get_pipeline_status(project_id, commit_sha)
>>> +        if status['status'] == 'running':
>>> +            time.sleep(interval)
>>> +            print('running...')
> 
> If we want to automate the use of this script by a daemon, it would
> be better to use the logging class. Then maybe 'running...' is for
> the DEBUG level, Other print() calls can be updated to WARN/INFO
> levels.
> 
>>> +            continue
>>> +
>>> +        if status['status'] == 'success':
>>> +            return True
>>> +
>>> +        msg = "Pipeline ended unsuccessfully, check: %s" % status['web_url']
>>
>> I think more common expression is "Pipeline failed"
>>
>>> +        print(msg)
>>> +        return False
>>> +
>> ...
>>
>> Code-wise looks OK to me, but since I don't know what Peter's requirements
>> on/expectations of this script are, I can't do a more thorough review.

Ok, I'll add some of the trivial suggestions and take this patch through
my gitlab tree, so Peter can start integrating the gitlab CI in his
merge workflow. We can then later add additional features like the
parameter for the branch name or the logging class.
(I'll skip the second patch for now since there were more questions
raised there which should likely be answered / discussed first)

 Thomas


