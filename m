Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86873C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 18:36:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B935205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 18:36:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B935205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3PHb-0002wI-Ae
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 14:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46056)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i3PG0-0001yv-GC
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 14:34:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i3PFy-0005u7-I1
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 14:34:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49580)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i3PFy-0005tb-AX
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 14:34:50 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3F88A85542
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 18:34:49 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id f10so2061010wmh.8
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 11:34:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6pAkZxn+zY6HDR2YnCWgMcfyE8oku6dy3G1bnawkBqk=;
 b=BuwQ1cBAWBqaVMPrxUdHNP2y6Mk5Sw8E7E/FaayawQOkRta/9hbeyl9f8daJ3zCPGh
 kk/dQlKJV4T9wGUaG4NFyVuUpWmHaozwqtH3OOO2O9vfHNDfSKpNDvj9iBx1iaCcAiPg
 yxIZjuv2/Vm8SfjKBZKhAeb6WRUEm47OIx+Fd8BlelLMuK2eNvI5O4oAcrymqdsyP9x3
 ThKxeJi3vlMralc3kHG2TAZmOcKObBfI9NOmCOajRNwgFm2OKlBVYJ3YU5z+QYdEhCl+
 FD/ezGl5yrz9ASZom93TNs7pYgGRy0TBylVF0qfu8RGmWJTFJvimt+KKBdsQLMxjzkS9
 T7oQ==
X-Gm-Message-State: APjAAAU9Qlnfy3kZ5TUBrf2/0XAOSgG8IM1RtysJvF26iI9ctAbm6LJf
 bLDcq58vnf6x4rwrjma//uTYEwFemdygjSmerrYE7SGtBNHKMs2+zBBzlD2KYbA/XkfhNHqNjaG
 EtC7+4eM+HhdXBew=
X-Received: by 2002:a1c:a7c6:: with SMTP id q189mr469283wme.22.1567103687836; 
 Thu, 29 Aug 2019 11:34:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzVnh7VmpoxDKDmVhOHnqhrwqEYie9N1d8Rjb3dFJQCjMnwXaBG9xZqh7eUkBMWuyswFUadaw==
X-Received: by 2002:a1c:a7c6:: with SMTP id q189mr469251wme.22.1567103687452; 
 Thu, 29 Aug 2019 11:34:47 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id f7sm6864210wrf.8.2019.08.29.11.34.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2019 11:34:46 -0700 (PDT)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20190820235243.26092-1-jsnow@redhat.com>
 <20190820235243.26092-5-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <0f7af7b1-cc53-a06b-5e53-bf091ec40683@redhat.com>
Date: Thu, 29 Aug 2019 20:34:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190820235243.26092-5-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 4/4] iotests: use python logging for
 iotests.log()
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
Cc: Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/21/19 1:52 AM, John Snow wrote:
> We can turn logging on/off globally instead of per-function.
> 
> Remove use_log from run_job, and use python logging to turn on
> diffable output when we run through a script entry point.
> 
> iotest 245 changes output order due to buffering reasons.
> ---
>  tests/qemu-iotests/030        |  4 +--
>  tests/qemu-iotests/245        |  1 +
>  tests/qemu-iotests/245.out    | 24 +++++++++---------
>  tests/qemu-iotests/iotests.py | 47 +++++++++++++++++++++--------------
>  4 files changed, 43 insertions(+), 33 deletions(-)
> 
> diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
> index 1b69f318c6..a382cb430b 100755
> --- a/tests/qemu-iotests/030
> +++ b/tests/qemu-iotests/030
> @@ -411,8 +411,8 @@ class TestParallelOps(iotests.QMPTestCase):
>          result = self.vm.qmp('block-job-set-speed', device='drive0', speed=0)
>          self.assert_qmp(result, 'return', {})
>  
> -        self.vm.run_job(job='drive0', auto_dismiss=True, use_log=False)
> -        self.vm.run_job(job='node4', auto_dismiss=True, use_log=False)
> +        self.vm.run_job(job='drive0', auto_dismiss=True)
> +        self.vm.run_job(job='node4', auto_dismiss=True)
>          self.assert_no_active_block_jobs()
>  
>      # Test a block-stream and a block-commit job in parallel
> diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
> index bc1ceb9792..3bc29acb33 100644
> --- a/tests/qemu-iotests/245
> +++ b/tests/qemu-iotests/245
> @@ -1000,4 +1000,5 @@ class TestBlockdevReopen(iotests.QMPTestCase):
>          self.reopen(opts, {'backing': 'hd2'})
>  
>  if __name__ == '__main__':
> +    iotests.activate_logging()
>      iotests.main(supported_fmts=["qcow2"])

Why not use:

       iotests.script_main(iotests.main, supported_fmts=['qcow2')

> diff --git a/tests/qemu-iotests/245.out b/tests/qemu-iotests/245.out
> index a19de5214d..15c3630e92 100644
> --- a/tests/qemu-iotests/245.out
> +++ b/tests/qemu-iotests/245.out
> @@ -1,17 +1,17 @@
> +{"execute": "job-finalize", "arguments": {"id": "commit0"}}
> +{"return": {}}
> +{"data": {"id": "commit0", "type": "commit"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
> +{"data": {"device": "commit0", "len": 3145728, "offset": 3145728, "speed": 0, "type": "commit"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
> +{"execute": "job-finalize", "arguments": {"id": "stream0"}}
> +{"return": {}}
> +{"data": {"id": "stream0", "type": "stream"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
> +{"data": {"device": "stream0", "len": 3145728, "offset": 3145728, "speed": 0, "type": "stream"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
> +{"execute": "job-finalize", "arguments": {"id": "stream0"}}
> +{"return": {}}
> +{"data": {"id": "stream0", "type": "stream"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
> +{"data": {"device": "stream0", "len": 3145728, "offset": 3145728, "speed": 0, "type": "stream"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
>  ..................
>  ----------------------------------------------------------------------
>  Ran 18 tests
>  
>  OK
> -{"execute": "job-finalize", "arguments": {"id": "commit0"}}
> -{"return": {}}
> -{"data": {"id": "commit0", "type": "commit"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
> -{"data": {"device": "commit0", "len": 3145728, "offset": 3145728, "speed": 0, "type": "commit"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
> -{"execute": "job-finalize", "arguments": {"id": "stream0"}}
> -{"return": {}}
> -{"data": {"id": "stream0", "type": "stream"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
> -{"data": {"device": "stream0", "len": 3145728, "offset": 3145728, "speed": 0, "type": "stream"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
> -{"execute": "job-finalize", "arguments": {"id": "stream0"}}
> -{"return": {}}
> -{"data": {"id": "stream0", "type": "stream"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
> -{"data": {"device": "stream0", "len": 3145728, "offset": 3145728, "speed": 0, "type": "stream"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> index 661d7f93bf..b97cc2fab2 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -35,6 +35,13 @@ from collections import OrderedDict
>  sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
>  from qemu import qtest
>  
> +# Use this logger for logging messages directly from the iotests module
> +logger = logging.getLogger(__name__)
> +logger.addHandler(logging.NullHandler())
> +
> +# Use this logger for messages that ought to be used for diff output.
> +test_logger = logging.getLogger('.'.join((__name__, 'iotest')))
> +test_logger.addHandler(logging.NullHandler())
>  
>  # This will not work if arguments contain spaces but is necessary if we
>  # want to support the override options that ./check supports.
> @@ -343,10 +350,10 @@ def log(msg, filters=[], indent=None):
>          separators = (', ', ': ') if indent is None else (',', ': ')
>          # Don't sort if it's already sorted
>          do_sort = not isinstance(msg, OrderedDict)
> -        print(json.dumps(msg, sort_keys=do_sort,
> -                         indent=indent, separators=separators))
> +        test_logger.info(json.dumps(msg, sort_keys=do_sort,
> +                                    indent=indent, separators=separators))
>      else:
> -        print(msg)
> +        test_logger.info(msg)
>  
>  class Timeout:
>      def __init__(self, seconds, errmsg = "Timeout"):
> @@ -559,7 +566,7 @@ class VM(qtest.QEMUQtestMachine):
>  
>      # Returns None on success, and an error string on failure
>      def run_job(self, job, auto_finalize=True, auto_dismiss=False,
> -                pre_finalize=None, cancel=False, use_log=True, wait=60.0):
> +                pre_finalize=None, cancel=False, wait=60.0):
>          """
>          run_job moves a job from creation through to dismissal.
>  
> @@ -572,7 +579,6 @@ class VM(qtest.QEMUQtestMachine):
>                               invoked prior to issuing job-finalize, if any.
>          :param cancel: Bool. When true, cancels the job after the pre_finalize
>                         callback.
> -        :param use_log: Bool. When false, does not log QMP messages.
>          :param wait: Float. Timeout value specifying how long to wait for any
>                       event, in seconds. Defaults to 60.0.
>          """
> @@ -590,8 +596,7 @@ class VM(qtest.QEMUQtestMachine):
>          while True:
>              ev = filter_qmp_event(self.events_wait(events))
>              if ev['event'] != 'JOB_STATUS_CHANGE':
> -                if use_log:
> -                    log(ev)
> +                log(ev)
>                  continue
>              status = ev['data']['status']
>              if status == 'aborting':
> @@ -599,24 +604,16 @@ class VM(qtest.QEMUQtestMachine):
>                  for j in result['return']:
>                      if j['id'] == job:
>                          error = j['error']
> -                        if use_log:
> -                            log('Job failed: %s' % (j['error']))
> +                        log('Job failed: %s' % (j['error']))
>              elif status == 'pending' and not auto_finalize:
>                  if pre_finalize:
>                      pre_finalize()
> -                if cancel and use_log:
> +                if cancel:
>                      self.qmp_log('job-cancel', id=job)
> -                elif cancel:
> -                    self.qmp('job-cancel', id=job)
> -                elif use_log:
> +                else:
>                      self.qmp_log('job-finalize', id=job)
> -                else:
> -                    self.qmp('job-finalize', id=job)
>              elif status == 'concluded' and not auto_dismiss:
> -                if use_log:
> -                    self.qmp_log('job-dismiss', id=job)
> -                else:
> -                    self.qmp('job-dismiss', id=job)
> +                self.qmp_log('job-dismiss', id=job)
>              elif status == 'null':
>                  return error
>  
> @@ -949,6 +946,7 @@ def execute_setup_common(supported_fmts=[],
>      if debug:
>          sys.argv.remove('-d')
>      logging.basicConfig(level=(logging.DEBUG if debug else logging.WARN))
> +    logger.debug("iotests debugging messages active")
>  
>      return debug
>  
> @@ -961,14 +959,25 @@ def execute_test(test_function=None, *args, **kwargs):
>      else:
>          test_function()
>  
> +def activate_logging():
> +    """Activate iotests.log() output to stdout for script-style tests."""
> +    handler = logging.StreamHandler(stream=sys.stdout)
> +    formatter = logging.Formatter('%(message)s')
> +    handler.setFormatter(formatter)
> +    test_logger.addHandler(handler)
> +    test_logger.setLevel(logging.INFO)
> +    test_logger.propagate = False
> +
>  # This is called from script-style iotests without a single point of entry
>  def script_initialize(*args, **kwargs):
>      """Initialize script-style tests without running any tests."""
> +    activate_logging()
>      execute_setup_common(*args, **kwargs)
>  
>  # This is called from script-style iotests with a single point of entry
>  def script_main(test_function, *args, **kwargs):
>      """Run script-style tests outside of the unittest framework"""
> +    activate_logging()
>      execute_test(test_function, *args, **kwargs)
>  
>  # This is called from unittest style iotests
> 

